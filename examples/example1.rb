require 'config'
require 'lib/apollo-client'

client = ApolloClient.new(apikey: APOLLO_API_KEY)

client.get_email(name: 'Rick Lapointe', company: 'USPRO')