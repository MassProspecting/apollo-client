# Enrichment

Ruby gem for connecting with Apollo.io.

## 1. Getting Started

1. Install the gem.

```bash
gem install blackstack-enrichment
```

2. Create a client.

You can define your [Apollo](https://www.apollo.io) API key:

```ruby
require 'blackstack-enrichment'
client = BlackStack::Enrichment.new(apollo_apikey: '<your apollo api key here>')
```

You can define your [FindyMail](https://findymail.com) API key:

```ruby
require 'blackstack-enrichment'
client = BlackStack::Enrichment.new(findymail_apikey: '<your findymail api key here>')
```

You can define both:

```ruby
require 'blackstack-enrichment'
client = BlackStack::Enrichment.new(
    apollo_apikey: '<your apollo api key here>',
    findymail_apikey: '<your findymail api key here>',
)
```

## 3. Find Person from LinkedIn URL

```ruby
client.find_person_email_from_linkedin_url(url: 'https://www.linkedin.com/in/richardglapointe')
=> richard@uspro.net
```

The Apollo API Key is mandatory for this operation.

## 4. Find Person from Name and Company

```ruby
client.find_person_from_name_and_company(name: 'Richard LaPointe', company: 'USPRO')
=> richard@uspro.net
```

The Apollo API Key is mandatory for this operation.

## 4. Find Person from Name and Domain

```ruby
client.find_person_from_name_and_domain(name: 'Richard LaPointe', domain: 'uspro.net')
=> richard@uspro.net
```

Either Apollo or FindyMail API Key is mandatory for this operation.
