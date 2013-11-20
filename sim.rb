require 'redis'

redis = Redis.new

commands = {
  "kicker:register:player:black:offence" => "Christian;christian.koestlin@esrlabs.com",
  "kicker:register:player:black:defense" => "Sebastian;sebastian.benz@esrlabs.com",
  "kicker:register:player:white:offence" => "Gerd;gerd.schaefer@esrlabs.com",
  "kicker:register:player:white:defense" => "Matthias;matthias.kessler@esrlabs.com"
}

commands.each do |key, value|
  redis.publish key, value
end



