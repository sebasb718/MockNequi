load 'pockets_manager.rb'

class PocketsSendMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['ENVIAR DINERO A USUARIO DESDE BOLSILLO',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_pockets_send_money_params
    pocket_manager = PocketsManager.new(@actual_session)
    pocket_manager.send_money_to_user_from_pocket(@pocket, @email, @amount)
    PocketsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_pockets_send_money_params
    puts 'Ingrese el nombre del bolsilo del que desea enviar dinero'
    @pocket = gets.chomp.to_s
    puts 'Ingrese email del destinatario'
    @email = gets.chomp.to_s
    puts 'Ingrese el monto a enviar'
    @amount = gets.chomp.to_i
  end
end
