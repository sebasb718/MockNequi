load 'transaction_manager.rb'
class PocketsManager
  def initialize(session_object)
    @actual_session = session_object
    @transaction_manager = TransactionManager.new(@actual_session)
  end

  def get_pockets
    pockets = @actual_session.database_accessor.pocket_queries.select_pockets(@actual_session.user_id)
    formatted_pockets = []
    pockets.each do |pocket|
      formatted_pockets << "Nombre: #{pocket['Name']} ------------ Dinero Disponible: #{pocket['AvailableMoney']}"
    end
    formatted_pockets
  end

  def send_money_to_user_from_pocket(pocket, destination_email, amount)
    pocket_valid?(pocket)
    origin_account = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(pocket, @actual_session.user_id)
    destination_user_data = @actual_session.database_accessor.user_queries.select_user(destination_email)
    raise 'El usuario destino no existe' if destination_user_data.count.zero?
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(destination_user_data.first['UserID'])
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end

  def deposit_money_on_pocket(name, amount)
    pocket_valid?(name)
    destination_account = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(name, @actual_session.user_id)
    origin_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end

  def withdraw_money_from_pocket(name, amount)
    pocket_valid?(name)
    origin_account = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(name, @actual_session.user_id)
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, amount)
  end

  def create_pocket(name)
    pocket_exists?(name)
    @actual_session.database_accessor.pocket_queries.insert_pocket(@actual_session.user_id, name)
  end

  def delete_pocket(name)
    pocket_valid?(name)
    origin_account = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(name, @actual_session.user_id)
    destination_account = @actual_session.database_accessor.account_queries.select_main_account(@actual_session.user_id)
    @transaction_manager.transaction_between_accounts(origin_account, destination_account, origin_account.first['AvailableMoney'].to_i)
    @actual_session.database_accessor.pocket_queries.inactive_pocket(@actual_session.user_id, name)
  end

  def pocket_exists?(name)
    possible_pocket = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(name, @actual_session.user_id)
    raise "El bolsillo #{name} ya existe" unless possible_pocket.count.zero?
  end

  def pocket_valid?(name)
    possible_pocket = @actual_session.database_accessor.pocket_queries.select_pocket_From_name(name, @actual_session.user_id)
    raise "El bolsillo #{name} no existe" if possible_pocket.count.zero?
  end
end
