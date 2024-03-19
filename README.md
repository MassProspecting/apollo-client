# Enrichment

Ruby gem for connecting with Apollo.io.

## 1. Getting Started

1. Install the gem.

```bash
gem install blackstack-enrichment
```

2. Create a client.

```ruby
require 'apollo-client'
client = BlackStack::Enrichment.new(apollo_apikey: '<your apollo api key here>')
```

## 3. Find Person from LinkedIn URL

```ruby
client.find_person_email_from_linkedin_url(url: 'https://www.linkedin.com/in/richardglapointe')
=> richard@uspro.com
```

## 4. Find Person from Name and Company

```ruby
client.find_person_from_name_and_company(name: 'Richard LaPointe', company: 'USPRO')
=> richard@uspro.com
```
