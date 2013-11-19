# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'redis'

Thread.start do
  redis = Redis.new
  redis.subscribe("events") do |on|
    puts "waiting for events"
    on.message do |channel, msg|
      send_event('my_widget', { text: msg})
      puts "##{channel} - #{msg}"
    end
  end
  puts "stopped for events"
end
