load 'mattress_available_money_view.rb'
load 'mattress_deposit_money_view.rb'
load 'mattress_withdraw_money_view.rb'

class MattressView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['Este es su colchón!',
     'Para ver el saldo de dinero en su colchón presione a',
     'Para realizar depósito de dinero al colchón desde su disponible presione b',
     'Para realizar retiro de dinero del colchón a su disponible presione c',
     'Para volver presione d']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'a'
      MattresAvailableMoneyView.new(@actual_session)
    when 'b'
      MattressDepositMoneyView.new(@actual_session)
    when 'c'
      MattressWithdrawMoneyView.new(@actual_session)
    when 'd'
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
