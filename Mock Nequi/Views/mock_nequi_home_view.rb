class MockNequiHomeView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['BIENVENIDO A MOCK NEQUI',
     '(Digite la tecla según el menú deseado y luego presione enter)',
     'Si es un usuario nuevo, digite 1 para registrarse',
     'Si ya tiene una cuenta, digite 2 para realizar el login',
     'Para salir del programa digite 3']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when '1'
      CreateUserView.new(@actual_session)
    when '2'
      LoginView.new(@actual_session)
    when '3'
      CloseProgramView.new
    else
      puts 'Entrada invalida'
      nil
    end
  end
end