class TimeFormatter

  ALL_FORMATS = {
      'year' => "%Y",
      'month' => "%m",
      'day' => "%d",
      'hour' => "%H",
      'min' => "%M",
      'sec' => "%S"
    }

  def initialize(query)
    @query = query
    @format_error = []
    @format_true = []
  end

  def call
    format = @query.gsub('format=', '').chomp('%').split('%2C')

    format.each do |form|
      if ALL_FORMATS.keys.include?(form)
        @format_true << ALL_FORMATS[form]
      else
        @format_error << form
      end
    end
  end

  def valid?
    @format_error.empty?
  end

  def valid_string
    time_output = []

    Time.now.strftime(@format_true.join('-'))
  end

  def invalid_string
    ["Unknown time format [#{@format_error.join(',')}]"]
  end

end
