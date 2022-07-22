require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest

  test "#current" do
    # FIXTURE_RESPONSE_FILE_PATH = "/../fixtures/files/example_response.xml"
    # apikey = '0vpO2tWxFBvjsSdENsH9d2haeCY4bg27'
    # base = 'http://dataservice.accuweather.com/currentconditions/v1'
    # city_code = '178087'
    # query = "?apikey=#{apikey}&details=true"
    # uri = URI("#{base}/#{city_code}#{query}")

    # stub_request(:get, uri)
    #   .to_return(body: File.read("#{File.dirname(__FILE__)}#{FIXTURE_RESPONSE_FILE_PATH}"), status: 200)

    # get current_url(format: :json)
    # json_response = JSON.parse(response.body)
    
    # assert_response :success
    # refute_nil json_response['temperature']
    # json_response['temperature'].is_a? String

  end

  test "#avg" do
    get avg_url(format: :json)
    json_response = JSON.parse(response.body)

    assert_response :success
    refute_nil json_response['temperature_avg']
  end

  # test "by_time" do
  #   get by_time_url(format: :json)
  #   json_response = JSON.parse(response.body)

  # end

  test "#each_hour" do
    get historical_url(format: :json)
    json_response = JSON.parse(response.body)

    assert_response :success
    refute_nil json_response.first['value']
    refute_nil json_response.first['created_at']
  end

  test "#health" do
    get health_url(format: :json)
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal json_response['Status'], 'OK'
  end

  test "#max" do
    get max_url(format: :json)
    json_response = JSON.parse(response.body)

    assert_response :success
    refute_nil json_response['temperature_max']
  end

  test "#min" do
    get min_url(format: :json)
    json_response = JSON.parse(response.body)
    
    assert_response :success
    refute_nil json_response['temperature_min']
  end

end
