# apollo-client

Ruby gem for connecting with Apollo.io.

## 1. Getting Started

1. Install the gem.

```bash
gem install apollo-client
```

2. Create a client.

```ruby
require 'apollo-client'
client = ApolloClient.new(apikey: '<your apollo api key here>')
```

## 3. Enrich a Lead

```ruby
client.get_email(name: 'Rick Lapointe', company: 'USPRO')
# => 'rick@uspro.com' 
```