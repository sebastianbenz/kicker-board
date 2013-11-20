# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'redis'

def avatar(email_address)
  return avatar_url(email_address) if File.exists?(avatar_path(email_address))
  return avatar_url( "oliver.mueller@esrlabs.com")
end

def avatar_path(email_address)
  "assets/images/avatars/#{email_address}.png"
end

def avatar_url(email_address)
  "/assets/avatars/#{email_address}.png"
end

def wait_for_player(color, position)
  Thread.new do
    redis = Redis.new
    redis.subscribe("kicker:register:player:#{color}:#{position}") do |on|
      on.message do |channel, msg|
          fragments = msg.split(";") 
          player = {
            name: fragments.first,
            avatar: avatar(fragments.last)
          }
          puts "sending event: #{player}"
          send_event("kicker-player-#{color}-#{position}", { player: player })
      end
    end
  end
end

wait_for_player("black", "offence")
wait_for_player("black", "defense")
wait_for_player("white", "offence")
wait_for_player("white", "defense")
