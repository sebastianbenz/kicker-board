#Protocol

## Channels

## Score kicker:game:score

    PUBLISH kicker:game:score "{
                                \"black\" : 1,
                                \"white\" : 2
                              }

## Goal kicker:game:goal

    PUBLISH kicker:game:goal "black"|"white"

## Register player kicker:register:player:COLOR:POSITION

    PUBLISH kicker:register:player:black:offence "Christian;christian.koestlin@esrlabs.com"
    PUBLISH kicker:register:player:black:defense "Sebastian;sebastian.benz@esrlabs.com"
    PUBLISH kicker:register:player:white:offence "Gerd;gerd.schaefer@esrlabs.com"
    PUBLISH kicker:register:player:white:defense "Matthias;matthias.kessler@esrlabs.com"

## Unregister player kicker:unregister:player:COLOR:POSITION

    PUBLISH kicker:unregister:player:black:defense

## Game Commands kicker:game:command:COMMAND

    PUBLISH kicker:game:command:reset

## Values

### Teams
    HGETALL kicker:game:players {
                    'black:offence' => 'Name;email'
                    '...' for all registered users
                    }
