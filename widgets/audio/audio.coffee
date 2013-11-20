class Dashing.Audio extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    document.getElementById("audio-signal").play();
