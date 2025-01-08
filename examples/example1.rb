# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require_relative '../config'
require_relative '../lib/apollo-client'

client = ApolloClient.new(apollo_apikey: APOLLO_API_KEY)

puts client.find_person_from_linkedin_url(url: 'http://www.linkedin.com/in/leandro-daniel-sardi-757387100')
