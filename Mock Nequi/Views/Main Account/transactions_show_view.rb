class TransactionsShowView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['TRANSACCIONES',
     'Escriba el numero de transacciones que desea mostrar y presione enter']
  end

  def get_next_view
    number = gets.chomp.to_i
    @transaction_manager = TransactionManager.new(@actual_session)
    transactions_for_show = @transaction_manager.get_transactions(number)
    transactions_for_show.each do |transaction|
      puts "#{transaction}"
    end
    puts 'Para continuar presione enter'
    gets.chomp
    UserHomeView.new(@actual_session)
  rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
