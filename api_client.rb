require 'net/http'
module OpenWeatherMap
  class Rest
    BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
    attr_reader :api_key
    def initialize
     @api_key = ENV['OPEN_WEATHER_MAP_APIKEY']
    end

    def get_by_city_name(city_name)
      validate
      parameter = {"q=" =>  city_name}
      rest_parameter = set_rest_hash_value(parameter)
      uri = URI.parse(BASE_URL + rest_parameter)
      return Net::HTTP.get(uri)
    end
    def get_by_city_id(id)
      validate
      parameter = {"id" =>  id}
      rest_parameter = set_rest_hash_value(parameter)
      uri = URI.parse(BASE_URL + rest_parameter)
      return Net::HTTP.get(uri) 
    end

    def get_by_geographic(lat, lon)
      validate
      parameter = {"lat" =>  lat}
      rest_parameter = set_rest_hash_value(parameter)
      uri = URI.parse(BASE_URL + rest_parameter)
      return Net::HTTP.get(uri) 

    end
    def get_by_zipcode(zipcode, country_code)
      validate
      parameter = {"zip" => zipcode.to_s << "," << country_code.to_s}
      p parameter
      rest_parameter = set_rest_hash_value(parameter)
      p rest_parameter
      uri = URI.parse(BASE_URL + rest_parameter)
      return Net::HTTP.get(uri) 
    end
    def set_rest_hash_value(parameter = {})
      validate
      query_str = "?"
      parameter["appid"] = @api_key 
      result_parameter = parameter.map{|k,v| "#{k}=#{v}"}.join("&")
      result_parameter = query_str + result_parameter
    end
    private
    def validate
      return "api key is empty. Set the OPEN_WEATHERMAP_KEY as ENV parameter" unless @api_key
      return true
    end
  end
end


