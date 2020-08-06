class TimeFormatter

  attr_reader :body

  ALL_FORMATS = ['year', 'month', 'day', 'hour', 'min', 'sec']

  def initialize(query)
    @query = query
    @format_error = []
    @format_true = []
  end

  def call
    @format = @query.gsub('format=', '').chomp('%').split('%2C')

    @format.each do |form|
      if ALL_FORMATS.include?(form)
        @format_true << form
      else
        @format_error << form
      end
    end
  end

  def create_body
    time = Time.now
    @time_hash = {}

    ALL_FORMATS.each do |form|
      @time_hash[form] = time.send(form)
    end

    if self.success?
      time_output
    else
      @body = ["Unknown time format [#{@error.join(',')}]"]
    end
  end

  def time_output
    @time_output = []

    @format_true.each do |form|
      @time_output << @time_hash[form]
      @body = [@time_output.join('-')]
    end
  end

  def success?
    true if @format_error.empty?
  end

end
