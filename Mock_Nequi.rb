load 'mock_nequi_home_view.rb'
load 'session.rb'
load 'menu.rb'

puts 'Ejecutando... por favor espere'
sleep(2)
Menu.new(MockNequiHomeView.new(Session.new)).show
