class Dashing.Player extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    $(@node).fadeOut().fadeIn() 
