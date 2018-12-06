class ApplicationAccesorManager
  def initialize(session)
    @actual_session = session
    @inputs_validator = UserInputsValidator.new
  end

  def create_user(email, password_try1, password_try2, first_name, last_name)
    @inputs_validator.valid_email?(email)
    @inputs_validator.valid_new_user_passwords?(password_try1, password_try2)
    encrypted_pass = @inputs_validator.encrypt(password_try1)
    possible_user = @actual_session.database_accessor.user_queries.select_user(email)
    raise 'El usuario ya existe' if possible_user.count != 0
    @actual_session.database_accessor.user_queries.create_user(email, first_name, last_name, encrypted_pass)
    @actual_session.database_accessor.account_queries.create_main_account_from_email(email)
    @actual_session.database_accessor.account_queries.create_mattress_from_email(email)
  end

  def login_new(email, password)
    user_data = @actual_session.database_accessor.user_queries.select_user(email)
    raise 'El usuario no existe' if user_data.count.zero?
    encrypted_pass = @inputs_validator.encrypt(password)
    database_pass = user_data.first['Password']
    @inputs_validator.valid_login_user_passwords?(encrypted_pass, database_pass)
    @actual_session.user_id = user_data.first['UserID']
  end
end

class UserInputsValidator
  def valid_email?(email)
    raise 'El email no es valido' unless email.include? '@'
  end

  def valid_new_user_passwords?(pass1, pass2)
    raise 'La contraseña no puede ser vacia' if pass1.empty?
    raise 'Las contraseñas no coinciden' if pass1 != pass2
  end

  def valid_login_user_passwords?(pass1, pass2)
    raise 'Contraseña incorrecta' if pass1 != pass2
  end

  def encrypt(password)
    Digest::SHA512.hexdigest(password)
  end
end
