class MainAccountAvailableMoneyView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    main_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    ["Su saldo disponible es: #{main_account.first["AvailableMoney"]} pesos", 'Presione Q para volver']
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
