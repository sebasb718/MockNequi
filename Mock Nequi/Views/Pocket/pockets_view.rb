class PocketsView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['Este es el menú de sus bolsillos!',
     'Para ver la información de sus bolsillos presione a',
     'Para crear nuevo bolsillo presione b',
     'Para eliminar bolsillo presione c',
     'Para realizar depósito de dinero a un bolsillo presione d',
     'Para realizar retiro de dinero de un bolsillo presione e',
     'Para enviar dinero a otro usuario desde un bolsillo presione f',
     'Para volver presione g']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'a'
      PocketsShowAllView.new(@actual_session)
    when 'b'
      PocketsCreateNewView.new(@actual_session)
    when 'c'
      PocketsDeleteView.new(@actual_session)
    when 'd'
      PocketsDepositMoneyView.new(@actual_session)
    when 'e'
      PocketsWithdrawMoneyView.new(@actual_session)
    when 'f'
      PocketsSendMoneyView.new(@actual_session)
    when 'g'
      UserHomeView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
