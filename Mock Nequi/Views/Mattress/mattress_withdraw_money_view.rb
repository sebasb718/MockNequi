class MattressWithdrawMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['RETIRAR DINERO DE COLCHON',
     'Ingrese la cantidad de dinero que desea retirar de su colchon a disponible y presione enter']
  end

  def get_next_view
    amount = gets.chomp.to_i
    mattress_manager = MattressManager.new(@actual_session)
    mattress_manager.withdraw_money_on_mattress(amount)
    MattressView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
