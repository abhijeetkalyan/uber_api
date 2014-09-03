=begin
Wrapper for the Uber API. API endpoints have been written as methods
within the Client class. Currently supports all API endpoints in v1,
please read the oauth/oauth_example.rb for how to generate bearer tokens
for OAuth endpoints(profile and history)
=end 
require "faraday"
require "faraday_middleware"
require "json"

module Uber
	class Client
		API_LOCATION = 'https://api.uber.com'
		API_VERSION = '/v1'
		attr_accessor :server_token ,:bearer_token

		def initialize(params={})
			params.each { |k,v| instance_variable_set("@#{k}", v) }
		end

		def conn
			@conn = Faraday.new API_LOCATION do |conn|
				conn.request :json
				conn.response :json, :content_type => /\bjson$/
				if !@bearer_token then conn.authorization :Token, @server_token else conn.authorization :Bearer , @bearer_token end 
				conn.adapter Faraday.default_adapter
			end
		end
		
		def get(endpoint, params)
			query_string = API_VERSION + endpoint
			response = conn.get query_string, params
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
			params = {:start_latitude => start_latitude.to_s, :start_longitude => start_longitude.to_s,
						:customer_uuid => customer_uuid.to_s, :product_id => product_id.to_s}
			response = get("/estimates/time", params)
			response["times"]
		end

		def history(offset, limit)
			params = {:offset => offset.to_s, :limit => limit.to_s}
			response = get("/history", params)
		end	

		def profile
			params = {}
			response = get("/me", params)
		end	
	end	
end
