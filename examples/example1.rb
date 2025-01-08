# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require_relative '../config'
require_relative '../lib/apollo-client'

client = BlackStack::Enrichment.new(apollo_apikey: APOLLO_API_KEY)

p client.find_person_from_linkedin_url(url: 'http://www.linkedin.com/in/leandro-daniel-sardi-757387100')
