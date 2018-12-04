class CloseProgramView
  def text
    ['Hasta pronto!', 'Presione enter para salir']
  end

  def get_next_view
    gets.chomp
    'Close'
  end
end