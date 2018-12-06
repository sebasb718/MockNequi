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
