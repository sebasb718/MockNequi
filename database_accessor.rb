require 'mysql2/em'

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

class UserQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def select_user(email)
    @mock_nequi_db.query("SELECT * FROM Users WHERE Email = '#{email}'")
  end

  def create_user(email, firstname, lastname, password)
    @mock_nequi_db.query("INSERT INTO Users (Email,FirstName,LastName,Password) values ('#{email}','#{firstname}','#{lastname}','#{password}')")
  end
end

class MattressQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def create_mattress_from_email(email)
    @mock_nequi_db.query("INSERT INTO Accounts (AccountTypeID, UserID, AvailableMoney, AccountStatus)
    VALUES (3, (SELECT UserID FROM users WHERE email = '#{email}'), 0, 1);")
  end

  def select_mattress(user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 3")
  end

  def update_money_on_mattress(user_id, new_amount)
    @mock_nequi_db.query("UPDATE Accounts SET AvailableMoney = #{new_amount} WHERE UserID = #{user_id} AND AccountTypeID = 3")
  end
end

class AccountQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end
  
  def create_main_account_from_email(email)
    @mock_nequi_db.query("INSERT INTO Accounts (AccountTypeID, UserID, AvailableMoney, AccountStatus)
    VALUES (1, (SELECT UserID FROM users WHERE email = '#{email}'), 0, 1);")
  end

  def select_main_account(user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 1")
  end

  def get_user_total_money(user_id)
    @mock_nequi_db.query("SELECT SUM(AvailableMoney) AS TotalUserMoney FROM Accounts WHERE UserID = #{user_id} AND AccountStatus = 1")
  end

  def update_money_on_account(account_id, new_amount)
    @mock_nequi_db.query("UPDATE Accounts SET AvailableMoney = #{new_amount} WHERE AccountID = #{account_id}")
  end

  def update_money_on_main_account(user_id, new_amount)
    @mock_nequi_db.query("UPDATE Accounts SET AvailableMoney = #{new_amount} WHERE UserID = #{user_id} AND AccountTypeID = 1")
  end
end

class TransactionQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def select_N_transactions(user_id, number_of_transactions)
    @mock_nequi_db.query("SELECT Origins.TrID, 
                          Origins.AcType AS OriginType, 
                          Origins.AcName AS OriginName,
                          Origins.Email AS OriginUser,
                          Origins.UserID AS OriginUserID,
                          Destinations.AcType AS DestinationType, 
                          Destinations.AcName AS DestinationName,
                          Destinations.Email AS DestinationUser,
                          Destinations.UserID AS DestinationUserID,
                          Origins.Transaction_date,
                          Origins.Money
                  FROM (SELECT T.transactionID AS TrID, B1.AccountTypeID, B2.AccountType AS AcType, B1.UserID, U.Email, B1.Name AS AcName, T.Money AS Money, T.Transaction_date AS Transaction_date
                      FROM Transactions AS T
                      LEFT JOIN Accounts AS B1 ON T.OriginAccountID = B1.AccountID 
                      LEFT JOIN AccountTypes AS B2 ON B1.AccountTypeID = B2.AccountTypeID
                        LEFT JOIN Users AS U ON B1.UserID = U.Email) AS Origins
                  JOIN (SELECT T.transactionID AS TrID, B1.AccountTypeID, B2.AccountType AS AcType, B1.UserID, U.Email, B1.Name AS AcName, T.Money AS Money
                      FROM Transactions AS T
                      LEFT JOIN Accounts AS B1 ON T.DestinationAccountID = B1.AccountID 
                      LEFT JOIN AccountTypes AS B2 ON B1.AccountTypeID = B2.AccountTypeID
                        LEFT JOIN Users AS U ON B1.UserID = U.Email) AS Destinations
                  ON Origins.TrID = Destinations.TrID
                  WHERE Origins.UserID = #{user_id} OR  Destinations.UserID = #{user_id}
                  ORDER BY Origins.TrID DESC
                  LIMIT #{number_of_transactions}")
  end

  def insert_transaction(origin, destination, money)
    origin = 'null' if origin.nil?
    destination = 'null' if destination.nil?
    @mock_nequi_db.query("INSERT INTO Transactions (OriginAccountID, DestinationAccountID, Money, Transaction_date) VALUES (#{origin},#{destination},#{money},'#{Time.now.utc.strftime('%Y-%m-%d %H:%M:%S')}')")
  end
end

class PocketQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def select_pockets(user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 2 AND AccountStatus = 1 ")
  end

  def select_pocket_From_name(name, user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 2 AND AccountStatus = 1 AND Name = '#{name}'")
  end

  def insert_pocket(user_id, name)
    @mock_nequi_db.query("INSERT INTO Accounts (AccountTypeID, UserID, AvailableMoney, AccountStatus, Name)
    VALUES (2, #{user_id}, 0, 1,'#{name}');")
  end

  def inactive_pocket(user_id, name)
    @mock_nequi_db.query("UPDATE Accounts SET AccountStatus = 0 WHERE UserID = #{user_id} AND AccountTypeID = 2 AND Name = '#{name}'")
  end
end

class GoalQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def select_goals(user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts AS Acc
    INNER JOIN GoalStatus AS GoSt ON Acc.goalstatusid = GoSt.goalstatusid
    WHERE UserID = #{user_id} AND AccountTypeID = 4 AND AccountStatus = 1 ")
  end

  def insert_goal(user_id, name, goal_date, goal_money)
    @mock_nequi_db.query("INSERT INTO Accounts (AccountTypeID, UserID, AvailableMoney, AccountStatus, Name, GoalDate, GoalStatusID, GoalMoney)
    VALUES (4, #{user_id}, 0, 1,'#{name}', '#{goal_date}', 1, #{goal_money});")
  end

  def select_goal_from_name(name, user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 4 AND AccountStatus = 1 AND Name = '#{name}'")
  end

  def close_goal(name, user_id)
    @mock_nequi_db.query("UPDATE Accounts SET AccountStatus = 0 WHERE UserID = #{user_id} AND AccountTypeID = 4 AND Name = '#{name}'")
  end
end
