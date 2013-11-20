# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'redis'
require 'json'

CONFIG_FILE = 'config.rb'

if File.exists?(CONFIG_FILE) 
  File.open(CONFIG_FILE) do |io|
    puts "{io.read}"
    eval(io.read)
  end
end

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

def wait_for_score
  previous_score = {}
  subscribe("kicker:game:score") do |channel, msg|
    score = JSON.parse(msg)
    puts "score: #{msg} -> #{score}"
    if score.all? { |key, value| value == 5 }
      send_event("audio-signal", { src: "/assets/hockey_charge.mp3" })
    end

    score.each do |key, value|
      puts "send event kicker-score-#{key} -> #{value}"
      if previous_score[key] != value
        send_event("kicker-score-#{key}", { text: value })
        previous_score[key] = value
      end
    end
  end
end


def wait_for_players
  subscribe("kicker:register:*") do |channel, msg|
    fragments = channel.split(":")
    color = fragments[3]
    position = fragments[4]

    fragments = msg.split(";") 
    player = {
      name: fragments.first,
      avatar: avatar(fragments.last)
    }
    puts "sending event: kicker-player-#{color}-#{position} "#{player}"
    send_event("kicker-player-#{color}-#{position}", { player: player })
  end
end

def subscribe(pattern)
  Thread.new do
    begin
      redis = Redis.new({host: REDIS_HOST})
      redis.psubscribe(pattern) do |on|
        on.pmessage do |_, channel, msg|
          yield channel, msg
        end
      end
    rescue Exception => e
      puts "we failed #{e}"
    end
  end
end

wait_for_players
wait_for_score
