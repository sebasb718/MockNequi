class GoalsCreateNewView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['CREAR NUEVA META',
     '(Digite la información solicitada y luego presione enter)']
  end

  def get_next_view
    get_new_goal_params
    goals_manager = GoalsManager.new(@actual_session)
    goals_manager.create_goal(@name, @date, @goal_amount)
    GoalsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end

  def get_new_goal_params
    puts 'Ingrese el nombre de la meta'
    @name = gets.chomp.to_s
    puts 'Ingrese la fecha limite de la meta (aaaa-mm-dd)'
    @date = gets.chomp.to_s
    puts 'Ingrese el monto a lograr con la meta'
    @goal_amount = gets.chomp.to_i
  end
end