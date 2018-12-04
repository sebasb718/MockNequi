class GoalsShowAllView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    header = ['A continuación se enlistan sus metas:',
              '(Para volver presione 1 y luego enter)']
    goals_manager = GoalsManager.new(@actual_session)
    header + goals_manager.get_goals
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when '1'
      GoalsView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
  end
end
