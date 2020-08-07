class TimeFormatter

  ALL_FORMATS = {
      'year' => Time.now.strftime("%Y"),
      'month' => Time.now.strftime("%m"),
      'day' => Time.now.strftime("%d"),
      'hour' => Time.now.strftime("%H"),
      'min' => Time.now.strftime("%M"),
      'sec' => Time.now.strftime("%S")
    }

  def initialize(query)
    @query = query
    @format_error = []
    @format_true = []
  end

  def call
    @format = @query.gsub('format=', '').chomp('%').split('%2C')

    @format.each do |form|
      if ALL_FORMATS.keys.include?(form)
        @format_true << form
      else
        @format_error << form
      end
    end
  end

  def valid?
    @format_error.empty?
  end

  def valid_string
    @time_output = []

    @format_true.each do |form|
      @time_output << ALL_FORMATS[form]
      [@time_output.join('-')]
    end
  end

  def invalid_string
    ["Unknown time format [#{@error.join(',')}]"]
  end

end
