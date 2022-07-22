class AddTemperatureJob < ApplicationJob
  queue_as :default

  def perform(*args)
    apikey = '0vpO2tWxFBvjsSdENsH9d2haeCY4bg27'
    base = 'http://dataservice.accuweather.com/currentconditions/v1'
    city_code = '178087'
    query = "?apikey=#{apikey}&details=true"
    uri = URI("#{base}/#{city_code}#{query}")
    response = Net::HTTP.get_response(uri)
    html = Nokogiri::HTML(response.body)
    data = JSON.parse(html)
    current_temperature = data.first['Temperature']['Metric']['Value'].to_f
    Temperature.create(value: current_temperature)
  end
end
