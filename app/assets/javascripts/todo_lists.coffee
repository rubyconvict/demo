ready = ->
  if $(".public_show_todo_list").length > 0
    socky = new Socky.Client(ws_host + '/websocket/ws_app')
    channel = socky.subscribe(channel_hash)

    # {"event"=>"todo_create",
    # "channel"=>"12e4f87c5d40427376bcc608a611cbae",
    # "timestamp"=>"1448378738",
    # "data"=>

      # "{\"id\":10,
      # \"title\":\"dsd\",
      # \"is_completed\":false,
      # \"todo_list_id\":5,
      # \"user_id\":1,
      # \"created_at\":\"2015-11-24T15:25:38.794Z\",
      # \"updated_at\":\"2015-11-24T15:25:38.794Z\"}"

    channel.bind "todo:create", (todo) ->
      window.location.reload()

    channel.bind "todo:update", (todo) ->
      window.location.reload()

    channel.bind "todo:update_many", () ->
      window.location.reload()

    channel.bind "todo:destroy", (todo) ->
      window.location.reload()

    channel.bind "todo:destroy_many", () ->
      window.location.reload()

    setInterval () ->
      channel.trigger("ping", { data: 'ok' })
    , 30000

$(document).ready(ready)
$(document).on('page:load', ready)
