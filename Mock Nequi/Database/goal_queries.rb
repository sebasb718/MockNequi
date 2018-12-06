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
