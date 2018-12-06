require_relative './App control/dependencies_for_load.rb'

class MockNequi
  def start
    Menu.new(MockNequiHomeView.new(Session.new)).show
  end
end

puts 'Ejecutando... por favor espere'
sleep(2)
MockNequi.new.start
