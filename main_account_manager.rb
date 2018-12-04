load 'transaction_manager.rb'

class MainAccountManager
  def initialize(session_object)
    @actual_session = session_object
    @transaction_manager = TransactionManager.new(@actual_session)
    end

  def deposit_money_on_main_account(amount)
    main_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_from_or_to_external(nil, main_account, amount)
  end

  def withdraw_money_from_main_account(amount)
    main_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_from_or_to_external(main_account, nil, amount)
  end

  def send_money_to_user_from_main_account(destination_email, amount)
    origin_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    destination_user_data = @actual_session.database_accessor.user_queries.select_user(destination_email)
    raise 'El usuario destino no existe' if destination_user_data.count.zero?
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(destination_user_data.first['UserID'])
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end
end
