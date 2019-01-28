App.files = App.cable.subscriptions.create "FilesChannel",
  connected: ->
    # console.log "connected: FilesChannel"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # console.log "disconnected: FilesChannel"
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # console.log "received: FilesChannel"
    # Called when there's incoming data on the websocket for this channel
    $("#latest-uploads").html(data.latest_uploads)
