class Menu
  def initialize(menu_view)
    @menu_view = menu_view
  end

  def show
    system('cls')
    @menu_view.text.each do |line|
      puts line.to_s
    end
    show_next_view
  end

  def show_next_view
    @next_view = @menu_view.get_next_view while @next_view.nil?
    Menu.new(@next_view).show unless @next_view == 'Close'
  end
end