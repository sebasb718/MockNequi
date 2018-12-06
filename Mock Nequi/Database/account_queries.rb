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
