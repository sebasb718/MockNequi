class Session
  attr_reader :database_accessor
  attr_accessor :user_id
  def initialize
    @database_accessor = DatabaseAccessor.new('localhost','root','root','nequi_mock')
    @user_id = nil
  end
end
