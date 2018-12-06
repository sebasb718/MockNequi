class LoginView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['INICIO DE SESIÓN',
     '(Digite la información solicitada y luego presione enter, para volver digite 1)']
  end

  def get_next_view
    get_login_params
    app_access_manager = ApplicationAccesorManager.new(@actual_session)
    app_access_manager.login_new(@email, @password)
    UserHomeView.new(@actual_session)
  rescue StandardError => e
    puts e.message
    nil
  end

  def get_login_params
    puts 'Ingrese su usuario (email)'
    @email = gets.chomp.to_s
    puts 'Ingrese su contraseña'
    @password = STDIN.getpass
  end
end
