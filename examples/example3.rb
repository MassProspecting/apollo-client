# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require_relative '../config'
require_relative '../lib/apollo-client'

client = BlackStack::Enrichment.new(
    #apollo_apikey: APOLLO_API_KEY,
    findymail_apikey: FINDYMAIL_API_KEY,
)

p client.find_person_from_name_and_domain(name: 'Richard LaPointe', domain: 'uspro.net')
