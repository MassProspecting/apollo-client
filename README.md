# Enrichment

Ruby gem for connecting with Apollo.io.

**Outline:**

1. [Getting Started](#1-getting-started)
2. [Find Person from LinkedIn URL](#2-find-person-from-linkedin-url)
3. [Find Person from Name and Company](#3-find-person-from-name-and-company)
4. [Find Person from Name and Domain](#4-find-person-from-name-and-domain)
5. [Find Person from Job Position and Domain](#5-find-person-from-job-position-and-domain)

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

## 2. Find Person from LinkedIn URL

```ruby
client.find_person_email_from_linkedin_url(url: 'https://www.linkedin.com/in/richardglapointe')
=> richard@uspro.net
```

The Apollo API Key is mandatory for this operation.

## 3. Find Person from Name and Company

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

## 5. Find Person from Job Position and Domain

```ruby
b = client.find_persons_from_title_and_domain(titles: ['CEO', 'Owner', 'President'], domain: 'benesch.com')
puts "#{b.first['first_name']}, #{b.first['last_name']}, #{b.first['title']}, #{b.first['emails'].first}".green
=> Steve, Tindale, Chief Executive Officer, stindale@benesch.com
```

Either Apollo or FindyMail API Key is mandatory for this operation.


## External Links

- [Apollo API Reference](https://knowledge.apollo.io/hc/en-us/articles/4416173158541-Use-the-Apollo-REST-API).
- [Findymail API Reference](https://app.findymail.com/docs).