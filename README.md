# UberApi
Ruby wrapper for the Uber API. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uber_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uber_api

## Usage
To begin with, simply initialize a new client, from which you can make API requests:
```ruby
client = Uber::Client.new(:server_token => 'YOUR_SERVER_TOKEN',:bearer_token => 'YOUR_BEARER_TOKEN')
```
At least one of the two parameters is necessary for using the API - the bearer token gets you access to all five endpoints,
while the server token gets you access to the products, prices and time endpoints.

The specific parameters for each endpoint, and the response fields, are detailed in the [Uber API docs](https://developer.uber.com/v1/endpoints/)

###Public Endpoints
Public endpoints can be accessed with only a server token. Some sample calls to the public endpoints are shown below:
```ruby
client.products(37.7759792, -122.41823)
=begin
{"capacity"=>4, "image"=>"http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberx.png", "display_name"=>"uberX", "product_id"=>"a1111c8c-c720-46c3-8534-2fcdd730040d", "description"=>"The low-cost Uber"}
{"capacity"=>6, "image"=>"http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberxl2.png", "display_name"=>"uberXL", "product_id"=>"821415d8-3bd5-4e27-9604-194e4359a449", "description"=>"low-cost rides for large groups"}
{"capacity"=>4, "image"=>"http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-black.png", "display_name"=>"UberBLACK", "product_id"=>"d4abaae7-f4d6-4152-91cc-77523e8165a4", "description"=>"The original Uber"}
{"capacity"=>6, "image"=>"http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-suv.png", "display_name"=>"UberSUV", "product_id"=>"8920cb5e-51a4-4fa4-acdf-dd86c5e18ae0", "description"=>"Room for everyone"}
{"capacity"=>4, "image"=>"http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-taxi.png", "display_name"=>"uberTAXI", "product_id"=>"3ab64887-4842-4c8e-9780-ccecd3a0391d", "description"=>"Taxi without the hassle"}
=end

client.prices(37.7753792, -122.51823, 37.7759792, -122.41823)
=begin
{"localized_display_name"=>"uberX", "low_estimate"=>"14", "display_name"=>"uberX", "product_id"=>"a1111c8c-c720-46c3-8534-2fcdd730040d", "surge_multiplier"=>1.0, "estimate"=>"$14-19", "high_estimate"=>"19", "currency_code"=>"USD"}
{"localized_display_name"=>"uberXL", "low_estimate"=>"24", "display_name"=>"uberXL", "product_id"=>"821415d8-3bd5-4e27-9604-194e4359a449", "surge_multiplier"=>1.0, "estimate"=>"$24-32", "high_estimate"=>"32", "currency_code"=>"USD"}
{"localized_display_name"=>"UberBLACK", "low_estimate"=>"38", "display_name"=>"UberBLACK", "product_id"=>"d4abaae7-f4d6-4152-91cc-77523e8165a4", "surge_multiplier"=>1.0, "estimate"=>"$38-50", "high_estimate"=>"50", "currency_code"=>"USD"}
{"localized_display_name"=>"UberSUV", "low_estimate"=>"49", "display_name"=>"UberSUV", "product_id"=>"8920cb5e-51a4-4fa4-acdf-dd86c5e18ae0", "surge_multiplier"=>1.0, "estimate"=>"$49-61", "high_estimate"=>"61", "currency_code"=>"USD"}
{"localized_display_name"=>"uberTAXI", "low_estimate"=>nil, "display_name"=>"uberTAXI", "product_id"=>"3ab64887-4842-4c8e-9780-ccecd3a0391d", "surge_multiplier"=>1, "estimate"=>"Metered", "high_estimate"=>nil, "currency_code"=>nil}
=end
```
###User Endpoints
User endpoints can be accessed in a similar manner to the public endpoints. However, you'll need a bearer token, which you can generate
using the oauth_example.rb sample sinatra app. The two user endpoint calls are:

```ruby
client.profile
```

```ruby
client.history(offset, limit)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/uber_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
