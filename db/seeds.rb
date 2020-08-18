# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'uri'
# require 'net/http'
# require 'openssl'
# def search
#     url = URI("https://mycookbook-io1.p.rapidapi.com/recipes/rapidapi")

#     http = Net::HTTP.new(url.host, url.port)
#     http.use_ssl = true
#     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

#     request = Net::HTTP::Post.new(url)
#     request["x-rapidapi-host"] = 'mycookbook-io1.p.rapidapi.com'
#     request["x-rapidapi-key"] = '22828bbb79msh7aa6b3024db9dbbp16309djsn7a34dd9c63c9'
#     request["content-type"] = 'text/plain'
#     request["accept"] = 'text/plain'
#     request.body = "https://www.jamieoliver.com/recipes/vegetasbles-recipes/superfood-salad/"

#     response = http.request(request)
#     response.read_body
# end

# require "uri"
# require "net/http"

#     url = URI("https://api.edamam.com/search")

#     https = Net::HTTP.new(url.host, url.port);
#     https.use_ssl = true

#     request = Net::HTTP::Get.new(url)

#     response = https.request(request)
#     puts response.read_body






