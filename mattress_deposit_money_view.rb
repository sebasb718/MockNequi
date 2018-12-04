load 'mattress_manager.rb'

class MattressDepositMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['INGRESAR DINERO A COLCHON',
     'Ingrese la cantidad de dinero que desea agregar de su disponible a su colchon y presione enter']
  end

  def get_next_view
    amount = gets.chomp.to_i
    mattress_manager = MattressManager.new(@actual_session)
    mattress_manager.deposit_money_on_mattress(amount)
    MattressView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
