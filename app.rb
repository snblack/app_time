require_relative "time_formatter"

class App

  def call(env)
    query = env['QUERY_STRING']

    if false_path?(env['PATH_INFO'])
      response(404, ['Change query'])
    else
      formatter = TimeFormatter.new(query)
      formatter.call

      if formatter.valid?
        response(200, formatter.valid_string)
      else
        response(400, formatter.invalid_string)
      end
    end

  end

  def headers
    {'Content-Type' => 'text/plain'}
  end

  private

  def false_path?(path)
    true if path != '/time'
  end

  def response(status, body)
    response = Rack::Response.new
    response.status = status
    response.body = body
    response.header = self.header
    response.finish
  end
end
