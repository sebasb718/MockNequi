load 'pockets_manager.rb'

class PocketsWithdrawMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['RETIRAR DINERO DE BOLSILLO A DISPONIBLE',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_pockets_withdraw_params
    pocket_manager = PocketsManager.new(@actual_session)
    pocket_manager.withdraw_money_from_pocket(@pocket, @amount)
    PocketsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_pockets_withdraw_params
    puts 'Ingrese el nombre del bolsilo del que desea retirar dinero'
    @pocket = gets.chomp.to_s
    puts 'Ingrese el monto a retirar al disponible'
    @amount = gets.chomp.to_i
  end
end
