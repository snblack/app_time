class TimeFormatter

  attr_reader :time

  ALL_FORMATS = ['year', 'month', 'day', 'hour', 'min', 'sec']

  def initialize(format, error)
    @format = format
    @error = error || []

    create_body
  end

  def create_body
    time = Time.now
    @time_hash = {}

    ALL_FORMATS.each do |form|
      @time_hash[form] = time.send(form)
    end

    if @error.any?
      ["Unknown time format [#{@error.join(',')}]"]
    else
      time_output
    end
  end

  def time_output
    @time_output = []

    @format.each do |form|
      @time_output << @time_hash[form] if @time_hash.keys.include?(form)
      @time = [@time_output.join('-')]
    end
  end

end
