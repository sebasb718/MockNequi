class MattressManager
  def initialize(session_object)
    @actual_session = session_object
    @transaction_manager = TransactionManager.new(@actual_session)
  end

  def deposit_money_on_mattress(amount)
    origin_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    destination_account = @actual_session.database_accessor.mattress_queries.select_mattress(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end

  def withdraw_money_on_mattress(amount)
    origin_account = @actual_session.database_accessor.mattress_queries.select_mattress(@actual_session.user_id)
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end
end
