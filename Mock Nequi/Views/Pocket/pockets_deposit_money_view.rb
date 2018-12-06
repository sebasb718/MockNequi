class PocketsDepositMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['DEPOSITAR DINERO EN BOLSILLO DESDE DISPONIBLE',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_pockets_deposit_params
    pocket_manager = PocketsManager.new(@actual_session)
    pocket_manager.deposit_money_on_pocket(@pocket, @amount)
    PocketsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_pockets_deposit_params
    puts 'Ingrese el nombre del bolsilo al que desea ingresar dinero'
    @pocket = gets.chomp.to_s
    puts 'Ingrese el monto a ingresar'
    @amount = gets.chomp.to_i
  end
end
