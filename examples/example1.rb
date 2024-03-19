require 'config'
require 'lib/blackstack-enrichment'

client = BlackStack::Enrichment.new(apollo_apikey: APOLLO_API_KEY)

p client.find_person_from_linkedin_url(url: 'https://www.linkedin.com/in/richardglapointe')