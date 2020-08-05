require_relative "time_formatter"

class App

    ALL_FORMATS = ['year', 'month', 'day', 'hour', 'min', 'sec']

  def call(env)
    @path = env['PATH_INFO']
    @query = env['QUERY_STRING']

    [status, headers, body]
  end

  private

  def status
    if false_path?
      404
    elsif false_format?
      400
    else
      200
    end
  end

  def headers
    {'Content-Type' => 'text/plain'}
  end

  def body
    time_formatter = TimeFormatter.new(@format_true, @format_error)
    time_formatter.time
  end

  private

  def false_path?
    true if @path != '/time'
  end

  def false_format?
    @format = @query.gsub('format=', '').chomp('%').split('%2C')

    @format_true = []
    @format_error = []

    @format.each do |form|
      if ALL_FORMATS.include?(form)
        @format_true << form
      else
        @format_error << form
      end
    end

    true if !@format_error.empty?
  end
end
