class MainAccountDepositMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['DEPOSITAR DINERO A CUENTA',
     'Ingrese la cantidad de dinero que desea agregar a su cuenta y presione enter']
  end

  def get_next_view
    amount = gets.chomp.to_i
    main_account_manager = MainAccountManager.new(@actual_session)
    main_account_manager.deposit_money_on_main_account(amount)
    UserHomeView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
