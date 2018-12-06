class PocketQueries
  def initialize(database_object)
    @mock_nequi_db = database_object
  end

  def select_pockets(user_id)
    @mock_nequi_db.query("SELECT * FROM Accounts WHERE UserID = #{user_id} AND AccountTypeID = 2 AND AccountStatus = 1 ")
  end

  def select_pocket_from_name(name, user_id)
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
