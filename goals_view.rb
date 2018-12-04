load 'goals_create_new_view.rb'
load 'goals_show_all_view.rb'
load 'goals_delete_view.rb'
load 'goals_deposit_money_view.rb'

class GoalsView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['Este es el menú de sus metas!',
     'Para ver la información de sus metas presione a',
     'Para crear nueva meta presione b',
     'Para cerrar una meta presione c',
     'Para realizar depósito de dinero a una meta presione d',
     'Para volver presione e']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'a'
      GoalsShowAllView.new(@actual_session)
    when 'b'
      GoalsCreateNewView.new(@actual_session)
    when 'c'
      GoalsDeleteView.new(@actual_session)
    when 'd'
      GoalsDepositMoneyView.new(@actual_session)
    when 'e'
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
