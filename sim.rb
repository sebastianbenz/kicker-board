require 'redis'

redis = Redis.new

commands = {
  "kicker:register:player:white:offence" => "Christian;christian.koestlin@esrlabs.com",
  "kicker:register:player:black:defense" => "Sebastian;sebastian.benz@esrlabs.com",
  "kicker:register:player:black:offence" => "Gerd;gerd.schaefer@esrlabs.com",
  "kicker:register:player:white:defense" => "Matthias;oliver.mueller@esrlabs.com"
}

commands.each do |key, value|
  puts redis.publish key, value
  sleep(1)
end

redis.publish "kicker:game:score", '{ "black": 6, "white": 5 }'
redis.publish "kicker:unregister:player:white:offence" , ""


