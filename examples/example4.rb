# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require_relative '../config'
require_relative '../lib/apollo-client'

require 'colorize'

a = [
    'southern-energy.com',
    'benesch.com',
    'biocair.com',
    'waketech.edu',
    'alliancehealthplan.org',
]

client = BlackStack::Enrichment.new(
    apollo_apikey: APOLLO_API_KEY,
    #findymail_apikey: FINDYMAIL_API_KEY,
)

a.each { |d|
    print "Domain: #{d.blue}... "
    b = client.find_persons_from_title_and_domain(titles: ['CEO', 'Owner', 'President'], domain: d)
    puts b.size==0 ? '0'.red : "#{b.first['first_name']} #{b.first['last_name']} #{b.first['title']} #{b.first['emails'].first}".green
}
