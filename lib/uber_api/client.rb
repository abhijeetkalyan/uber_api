require "faraday"
require "faraday_middleware"
require "json"

module Uber
	class Client
		API_LOCATION = 'https://api.uber.com'
		API_VERSION = '/v1'
		attr_accessor :client_id , :server_token , :secret , :bearer_token

		def initialize(params={})
			params.each { |k,v| instance_variable_set("@#{k}", v) }
		end

		def get(endpoint, params)
			conn = Faraday.new API_LOCATION do |conn|
				conn.request :json
				conn.response :json, :content_type => /\bjson$/
				conn.authorization :Token, @server_token
				conn.adapter Faraday.default_adapter
			end
			response = conn.get API_VERSION.concat(endpoint) , params
			response_hash = JSON.parse(response.body.to_json)
		end
		
		def products(latitude, longitude)
			params = {:latitude => latitude.to_s, :longitude => longitude.to_s}
			response = get("/products", params)
			response["products"]		
		end	

		def prices(start_latitude, start_longitude, end_latitude, end_longitude)
			params = {:start_latitude => start_latitude.to_s, :start_longitude => start_longitude.to_s,
						:end_latitude => end_latitude.to_s, :end_longitude => end_longitude.to_s}
			response = get("/estimates/price", params)
			response["prices"]
		end

		def times(start_latitude, start_longitude, customer_uuid, product_id)
			params = {
				:start_longitude => start_longitude.to_s, :start_longitude => start_longitude.to_s,
				:customer_uuid => customer_uuid.to_s, :product_id => product_id.to_s
			}
			response = get("/estimates/time", params)
			response["times"]
		end	
	end	
end
