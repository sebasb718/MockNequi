class MainAccountWithdrawMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['RETIRAR DINERO DE CUENTA',
     'Ingrese la cantidad de dinero que desea retirar de su cuenta y presione enter']
  end

  def get_next_view
    amount = gets.chomp.to_i
    main_account_manager = MainAccountManager.new(@actual_session)
    main_account_manager.withdraw_money_from_main_account(amount)
    UserHomeView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
