require_relative "time_formatter"

class App

  def call(env)
    @path = env['PATH_INFO']
    @query = env['QUERY_STRING']

    if false_path?
      status = 404
      body = ['Change query']
      response(status, body)
    else
      time_formatter = TimeFormatter.new(@query)
      time_formatter.call
      time_formatter.create_body
      @headers = {'Content-Type' => 'text/plain'}
      [status, headers, body]
    end

  end

  private

  def status
    if time_formatter.success?
      200
    else
      400
    end
  end

  def headers
    {'Content-Type' => 'text/plain'}
  end

  def body
    time_formatter.body
  end

  private

  def false_path?
    true if @path != '/time'
  end

  def response(status, body)
    Rack::Response.status = status
    Rack::Response.body = body
  end
end
