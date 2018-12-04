class TransactionManager
  def initialize(session_object)
    @actual_session = session_object
  end

  def get_transactions(number_of_transactions)
    transactions = @actual_session.database_accessor.transaction_queries.select_N_transactions(@actual_session.user_id, number_of_transactions)
    @formatted_transactions = []
    transactions.each do |transaction|
      @formatted_transactions << format_transaction_row(transaction)
    end
    @formatted_transactions
  end

  def format_transaction_row(row)
    if row["OriginType"] == nil
      format_text = "Tipo:Ingreso ---- Origen:Externo ---- Destino:#{row['DestinationType']} ---- Monto:#{row['Money']} ---- Fecha:#{row['Transaction_date']}"
      return format_text
    elsif row["DestinationType"] == nil
      format_text = "Tipo:Retiro ---- Origen:#{row['OriginType']} ---- Destino:Externo ---- Monto:#{row['Money']} ---- Fecha:#{row['Transaction_date']}"
      return format_text
    elsif row["OriginUser"] == row["DestinationUser"]
      format_text = "Tipo:Movimiento ---- Origen:#{row['OriginType'] +' '+ row['OriginName'].to_s} ---- Destino:#{row['DestinationType'] +' '+ row['DestinationName'].to_s} ---- Monto:#{row['Money']} ---- Fecha:#{row['Transaction_date']}"
      return format_text
    elsif row["OriginUserID"] != @actual_session.user_id
      format_text = "Tipo:Recepcion ---- Origen:#{row['OriginType'] +' '+ row['OriginName'].to_s+' '+ row['OriginUser'].to_s} ---- Destino:#{row['DestinationType']} ---- Monto:#{row['Money']} ---- Fecha:#{row['Transaction_date']}"
      return format_text
    elsif row["DestinationUserID"] != @actual_session.user_id
      format_text = "Tipo:Envio ---- Origen:#{row['OriginType'] +' '+ row['OriginName'].to_s} ---- Destino:#{row['DestinationType']+' '+ row['DestinationUser'].to_s} ---- Monto:#{row['Money']} ---- Fecha:#{row['Transaction_date']}"
      return format_text
    end
  end

  def transaction_from_or_to_external(origin_account, destination_account, amount)
    verify_if_valid(amount)
    if origin_account.nil?
      new_money = destination_account.first['AvailableMoney'].to_i + amount
      @actual_session.database_accessor.account_queries.update_money_on_account(destination_account.first['AccountID'], new_money)
      @actual_session.database_accessor.transaction_queries.insert_transaction(nil, destination_account.first['AccountID'].to_i, amount)
    elsif destination_account.nil?
      verify_if_enough_on_account(origin_account.first['AvailableMoney'].to_i, amount)
      new_money = origin_account.first['AvailableMoney'].to_i - amount
      @actual_session.database_accessor.account_queries.update_money_on_account(origin_account.first['AccountID'], new_money)
      @actual_session.database_accessor.transaction_queries.insert_transaction(origin_account.first['AccountID'].to_i, nil, amount)
    end
end

  def transaction_between_accounts(origin_account, destination_account, amount)
    verify_if_valid(amount)
    verify_if_enough_on_account(origin_account.first['AvailableMoney'].to_i, amount)
    new_origin_money = origin_account.first['AvailableMoney'].to_i - amount
    new_destination_money = destination_account.first['AvailableMoney'].to_i + amount
    @actual_session.database_accessor.account_queries.update_money_on_account(origin_account.first['AccountID'], new_origin_money)
    @actual_session.database_accessor.account_queries.update_money_on_account(destination_account.first['AccountID'], new_destination_money)
    @actual_session.database_accessor.transaction_queries.insert_transaction(origin_account.first['AccountID'].to_i, destination_account.first['AccountID'].to_i, amount)
  end

  def verify_if_valid(amount)
    raise 'Monto no valido' if amount.zero?
  end

  def verify_if_enough_on_account(account_amount, amount_for_verify)
    raise 'Monto es superior al disponible' if amount_for_verify > account_amount
  end
end
