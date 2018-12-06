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
