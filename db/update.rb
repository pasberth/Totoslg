root = File.dirname(__FILE__)

Dir["#{root}/data/unit_type/**/*.rb"].each do |unit_data|
  require File.expand_path(unit_data)
end

Dir["#{root}/data/character/**/*.rb"].each do |map_data|
  require File.expand_path(map_data)
end

Dir["#{root}/data/square_type/**/*.rb"].each do |unit_data|
  require File.expand_path(unit_data)
end

Dir["#{root}/data/map/**/*.rb"].each do |map_data|
  require File.expand_path(map_data)
end
  
Dir["#{root}/data/stage/**/*.rb"].each do |map_data|
  require File.expand_path(map_data)
end
