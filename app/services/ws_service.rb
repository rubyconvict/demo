class WsService
  def initialize(record)
    @record = record
    @ws_connection = Socky::Client.new("#{ENV['http_host']}/http/ws_app", ENV['ws_password'])
  end

  def call(event, data = {})
    @ws_connection.trigger!(event, channel: @record.slug, data: data)
  rescue StandardError
    Rails.logger.debug 'Websocket server is down'
  end
end
