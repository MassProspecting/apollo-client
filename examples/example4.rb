# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require 'config'
require 'lib/blackstack-enrichment'

client = BlackStack::Enrichment.new(
    apollo_apikey: APOLLO_API_KEY,
    #findymail_apikey: FINDYMAIL_API_KEY,
)

p client.find_persons_from_title_and_domain(titles: ['CEO', 'Owner', 'President'], domain: 'uspro.net')
