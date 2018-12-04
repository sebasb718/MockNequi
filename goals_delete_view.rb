class GoalsDeleteView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['CERRAR UNA META',
     'Escriba el nombre de la meta que desea cerrar y presione enter']
  end

  def get_next_view
    goal_name = gets.chomp.to_s
    goals_manager = GoalsManager.new(@actual_session)
    goals_manager.finish_goal(goal_name)
    GoalsView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end