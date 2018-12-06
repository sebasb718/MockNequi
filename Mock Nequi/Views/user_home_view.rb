class UserHomeView
  def initialize(session_object)
    @actual_session = session_object
  end

  def text
    ['BIENVENIDO!',
     '(Digite la tecla según el menú deseado y luego presione enter)',
     'Para ver el saldo disponible digite a',
     'Para ver el saldo total digite b',
     'Para realizar depósito de dinero digite c',
     'Para realizar retiro de dinero digite d',
     'Para enviar dinero a otro usuario (desde el disponible de su cuenta) digite e',
     'Para consultar sus últimas transacciones digite f',
     'Para ver el "colchón" digite g',
     'Para entrar al menú de bolsillos digite h',
     'Para entrar al menú de sus metas digite i',
     'Para cerrar sesion digite j']
  end

  def get_next_view
    input = gets.chomp.to_s
    case input
    when 'a'
      MainAccountAvailableMoneyView.new(@actual_session)
    when 'b'
      MainAccountTotalMoneyView.new(@actual_session)
    when 'c'
      MainAccountDepositMoneyView.new(@actual_session)
    when 'd'
      MainAccountWithdrawMoneyView.new(@actual_session)
    when 'e'
      MainAccountSendMoneyView.new(@actual_session)
    when 'f'
      TransactionsShowView.new(@actual_session)
    when 'g'
      MattressView.new(@actual_session)
    when 'h'
      PocketsView.new(@actual_session)
    when 'i'
      GoalsView.new(@actual_session)
    when 'j'
      MockNequiHomeView.new(@actual_session)
    else
      puts 'Invalid'
      nil
    end
    rescue StandardError => e
    puts "Error: #{e.message}"
    nil
  end
end
