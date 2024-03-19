require 'config'
require 'lib/enrichment'

client = BlackStack::Enrichment.new(
    apollo_apikey: APOLLO_API_KEY,
    findymail_apikey: FINDYMAIL_API_KEY,
)

p client.find_person_from_name_and_company(name: 'Richard LaPointe', company: 'USPRO')
