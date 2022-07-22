require 'open-uri'

class WeatherController < ApplicationController
  skip_before_action :verify_authenticity_token


  def current
    apikey = '0vpO2tWxFBvjsSdENsH9d2haeCY4bg27'
    base = 'http://dataservice.accuweather.com/currentconditions/v1'
    city_code = '178087'
    query = "?apikey=#{apikey}&details=true"
    uri = URI("#{base}/#{city_code}#{query}")
    response = Net::HTTP.get_response(uri)
    html = Nokogiri::HTML(response.body)
    data = JSON.parse(html)
    current_temperature = data.first['Temperature']['Metric']['Value']
    
    title = 'temperature'

    confirmation_response(title, current_temperature)
  end


  def avg

    data = get_temperatures_24h()
    temperatures_values = get_temperatures_values(data)

    length = temperatures_values.length
    @avg_temperature = temperatures_values.sum / length
    confirmation_response('temperature_avg', @avg_temperature)
  end

  def by_time 

    epoch_time = params[:epoch_time]
    date = Time.at(epoch_time.to_f).to_datetime

    @temperatures = get_temperatures_24h()
    date_temperature = nil
    @temperatures.each do |temperature|

      if ((temperature.created_at > date - 30.minutes) && (temperature.created_at < date + 30.minutes))
        date_temperature = temperature
      end
    end

    if date_temperature
      confirmation_response('temperature', date_temperature)
    else
      confirmation_response('status', 'error')
    end

  end

  def each_hour
    
    @temperatures = get_temperatures_24h()
    render json: @temperatures.as_json(only: [:value, :created_at])

  end

  def health 
    title = 'Status'
    value = 'OK'

    confirmation_response(title, value)
  end

  def max

    data = get_temperatures_24h()
    temperatures_values = get_temperatures_values(data)

    @max_temperature = temperatures_values.max
    confirmation_response('temperature_max', @max_temperature)
  end

  def min

    data = get_temperatures_24h()
    temperatures_values = get_temperatures_values(data)

    @min_temperature = temperatures_values.min
    confirmation_response('temperature_min', @min_temperature)
  end





  private

  def confirmation_response(title, value)
    respond_to do |format|
      format.json do
        render json:  {"#{title}": value}
      end
    end
  end

  def get_temperatures_24h
    @temperatures = Temperature.all
    temperatures_in_24h = []
    @temperatures.each do |temperature|
      
      if temperature.created_at > Time.now - 1124.hours
        temperatures_in_24h << temperature
      end
    end
    temperatures_in_24h
  end

  def get_temperatures_values instances

    temperatures_values = []
    instances.each do |temperature|
      temperatures_values << temperature.value
    end
    temperatures_values
  end
end



