class Dashing.Text extends Dashing.Widget

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    $(@node).fadeOut().fadeIn() 

    console.log(data);
