# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'redis'

def wait_for_player(redis, color, position)
  Thread.start do
    redis.subscribe("kicker:register:player:#{color}:#{position}") do |on|
      on.message do |channel, msg|
        puts "#{{ "player_#{color}_#{position}.name" => msg}}"
        send_event("kickerid", { "player_#{color}_#{position}.name" => msg})
        send_event("kickerid", { "value" =>  "#{msg}" })
        puts "##{channel} - #{msg}"
      end
    end
  end
end

redis = Redis.new
wait_for_player(redis, "black", "back")
