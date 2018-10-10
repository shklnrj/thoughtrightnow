$(document).ready ->
  feed_id = $('#feed_id')[0].value
  App.feed = App.cable.subscriptions.create {channel: "FeedChannel", feed_id: feed_id},
    collection: -> $("[data-channel='feed_items']")
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#feed_table').prepend("<tr><td>#{data['message']}</td><td>#{data['email']}</td></tr>");
      $('#feed').prepend
      # Called when there's incoming data on the websocket for this channel
