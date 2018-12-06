class GoalsDepositMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['DEPOSITAR DINERO EN META DESDE DISPONIBLE',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_goals_deposit_params
    goal_manager = GoalsManager.new(@actual_session)
    goal_manager.deposit_money_on_goal(@goal, @amount)
    GoalsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_goals_deposit_params
    puts 'Ingrese el nombre de la meta a la que desea ingresar dinero'
    @goal = gets.chomp.to_s
    puts 'Ingrese el monto a ingresar'
    @amount = gets.chomp.to_i
  end
end
