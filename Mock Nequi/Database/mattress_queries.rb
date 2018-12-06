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
