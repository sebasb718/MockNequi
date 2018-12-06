class MattresAvailableMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    mattress = @actual_session.database_accessor.mattress_queries.select_mattress(@actual_session.user_id)
    ["Su saldo disponible en el colchon es: #{mattress.first['AvailableMoney']} pesos", 'Presione Q para volver']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'Q'
      MattressView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
  end
end
