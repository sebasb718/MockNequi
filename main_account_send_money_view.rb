load 'main_account_manager.rb'

class MainAccountSendMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['ENVIAR DINERO A USUARIO',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_send_to_params
    main_account_manager = MainAccountManager.new(@actual_session)
    main_account_manager.send_money_to_user_from_main_account(@email, @amount)
    UserHomeView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_send_to_params
    puts 'Ingrese email del destinatario'
    @email = gets.chomp.to_s
    puts 'Ingrese el monto a enviar'
    @amount = gets.chomp.to_i
  end
end
