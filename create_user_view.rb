require 'digest'
require 'io/console'
load 'application_accesor_manager.rb'

class CreateUserView
  def initialize(session_object)
    @actual_session = session_object
  end
  
  def text
    ['CREACIÓN DE USUARIO',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_new_user_params
    app_access_manager = ApplicationAccesorManager.new(@actual_session)
    app_access_manager.create_user(@email, @pass1, @pass2, @first_name, @last_name)
    MockNequiHomeView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_new_user_params
    puts 'Ingrese su email'
    @email = gets.chomp.to_s
    puts 'Ingrese su contraseña'
    @pass1 = STDIN.getpass
    puts 'Repita su contraseña'
    @pass2 = STDIN.getpass
    puts 'Ingrese su nombre'
    @first_name = gets.chomp.to_s
    puts 'Ingrese su apellido'
    @last_name = gets.chomp.to_s
  end
end


