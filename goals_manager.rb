load 'transaction_manager.rb'

class GoalsManager
  def initialize(session_object)
    @actual_session = session_object
    @transaction_manager = TransactionManager.new(@actual_session)
  end

  def get_goals
    goals = @actual_session.database_accessor.goal_queries.select_goals(@actual_session.user_id)
    formatted_goals = []
    goals.each do |goal|
      formatted_goals << "Nombre:#{goal['Name']} ------ Estatus:#{goal['GoalStatus']} ------ Dinero Ahorrado:#{goal['AvailableMoney']} ------ Dinero Objetivo:#{goal['GoalMoney']} ------ Fecha:#{goal['GoalDate']}"
    end
    formatted_goals
  end

  def create_goal(name, date, goal_amount)
    goal_exists?(name)
    formated_date = date_valid?(date)
    raise 'La fecha de la meta debe ser mayor a la fecha actual' if formated_date <= Date.today
    @actual_session.database_accessor.goal_queries.insert_goal(@actual_session.user_id, name, formated_date, goal_amount)
  end

  def deposit_money_on_goal(name, amount)
    goal_valid?(name)
    destination_account = @actual_session.database_accessor.goal_queries.select_goal_from_name(name, @actual_session.user_id)
    origin_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end

  def finish_goal(name)
    goal_valid?(name)
    origin_account = @actual_session.database_accessor.goal_queries.select_goal_from_name(name, @actual_session.user_id)
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, origin_account.first['AvailableMoney'].to_i)
    @actual_session.database_accessor.goal_queries.close_goal(name, @actual_session.user_id)
  end

  def goal_exists?(name)
    possible_goal = @actual_session.database_accessor.goal_queries.select_goal_from_name(name, @actual_session.user_id)
    raise "La meta #{name} ya existe" unless possible_goal.count.zero?
  end

  def goal_valid?(name)
    possible_goal = @actual_session.database_accessor.goal_queries.select_goal_from_name(name, @actual_session.user_id)
    raise "La meta #{name} no existe" if possible_goal.count.zero?
  end

  def date_valid?(date)
    valid_format = '%Y-%m-%d'
    begin
      formated_date = Date.strptime(date, valid_format)
    rescue StandardError
      raise 'El formato de fecha no es correcto'
    end
  end
end
