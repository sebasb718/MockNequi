class MainAccountTotalMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    total_for_user = @actual_session.database_accessor.account_queries.get_user_total_money(@actual_session.user_id)
    ["Su saldo total es: #{total_for_user.first["TotalUserMoney"]} pesos", 'Presione Q para volver']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'Q'
      UserHomeView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
  end
end
