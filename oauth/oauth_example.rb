=begin
An example Sinatra app for generating bearer tokens. 
To generate bearer tokens, simply fill in your client ID and secert and run this app from
the console : ruby oauth_example.rb . The app will then navigate through the steps of the OAuth
workflow with the specified redirect URI. (To test this successfully, you'll need to have 
'http://localhost:4567/auth' as the redirect URI for your app - you can set this on your Uber developer dashboard.
=end
require 'sinatra'
require 'faraday'
require 'faraday_middleware'
CLIENT_ID = ENV['UBER_CLIENT_ID']
REDIRECT_URL = 'http://localhost:4567/auth' 
SECRET = ENV['UBER_SECRET']
AUTH_URL = 'https://login.uber.com/oauth/authorize'
TOKEN_URL = 'https://login.uber.com/oauth/token'

get '/' do
	query_string = Rack::Utils.build_query({
		:client_id => CLIENT_ID,
		:redirect_uri => REDIRECT_URL,
		:response_type => "code"
		})
	redirect "#{AUTH_URL}?#{query_string}"
end

get "/auth" do
	query_string = Rack::Utils.build_query({
		:client_secret => SECRET,
		:client_id => CLIENT_ID,
		:grant_type => "authorization_code",
		:redirect_uri => REDIRECT_URL,
		:code => params[:code]
		})
	puts query_string
	puts params[:code]
	response = Faraday.post("#{TOKEN_URL}?#{query_string}")
	"#{response.body}"
end	