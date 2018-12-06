class DatabaseAccessor
  attr_reader :user_queries, :transaction_queries, :account_queries, :mattress_queries, :pocket_queries, :goal_queries

  def initialize(host, user, pass, db_name)
    @db_host = host
    @db_user  = user
    @db_pass  = pass
    @db_name = db_name
    database_object = connect_database
    @user_queries = UserQueries.new(database_object)
    @account_queries = AccountQueries.new(database_object)
    @mattress_queries = MattressQueries.new(database_object)
    @transaction_queries = TransactionQueries.new(database_object)
    @pocket_queries = PocketQueries.new(database_object)
    @goal_queries = GoalQueries.new(database_object)
  end

  def connect_database
    Mysql2::Client.new(host: @db_host, username: @db_user, password: @db_pass, database: @db_name)
  end
end