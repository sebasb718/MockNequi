class PocketsShowAllView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    header = ['A continuación se enlistan sus bolsillos:',
              '(Para volver presione 1 y luego enter)']
    pocket_manager = PocketsManager.new(@actual_session)
    header + pocket_manager.get_pockets
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when '1'
      PocketsView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
  end
end
