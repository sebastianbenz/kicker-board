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

def wait_for_players
  Thread.new do
    begin
      redis = Redis.new
      redis.psubscribe("kicker:register:*") do |on|
        on.pmessage do |channel, msg|
          puts "received #{msg} on #{channel}"
          fragments = channel.split(":")
          color = fragments[3]
          position = fragments[4]

          fragments = msg.split(";") 
          player = {
            name: fragments.first,
            avatar: avatar(fragments.last)
          }
          puts "sending event: #{player}"
          send_event("kicker-player-#{color}-#{position}", { player: player })
        end
      end
    rescue Exception => e
      puts "we failed #{e}"
    end
  end
end

wait_for_players()
