require 'json'

module BlackStack
    class Enrichment
        @@apollo_apikey = nil

        def initialize(h={})
            @apollo_apikey = h[:apollo_apikey]
            @findymail_apikey = h[:findymail_apikey]
        end # def initialize

        # Retrieve the email of a person from a LinkedIn URL
        #
        # Reference: https://apolloio.github.io/apollo-api-docs/?shell#enrichment-api
        #
        # 
        def find_person_from_linkedin_url(url:)
            raise 'Error: apollo_apikey is required for find_person_from_linkedin_url operation.' if @apollo_apikey.nil?

            ret = `curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
                "api_key": "#{@apollo_apikey}",
                "reveal_personal_emails": true,
                "details": [
                    {
                        "linkedin_url": "#{url}"
                    }
                ]
            }' "https://api.apollo.io/api/v1/people/bulk_match"`
            j = JSON.parse(ret)
            raise "Error: #{j['error_message']}" if j['error_message']
            raise "Error: #{j['error_code']}" if j['error_code']
            raise "Error: #{j['error']}" if j['error']
            match = j['matches'].first
            return nil if match.nil?
            match['email']
        end # def find_person_email_from_linkedin_url

        # Retrieve the email of a person from his name and company.
        #
        # Reference: https://apolloio.github.io/apollo-api-docs/?shell#enrichment-api
        #
        # 
        def find_person_from_name_and_company(name:, company:)
            raise 'Error: apollo_apikey is required for find_person_from_name_and_company operation.' if @apollo_apikey.nil?

            ret = `curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
                "api_key": "#{@apollo_apikey}",
                "reveal_personal_emails": true,
                "details": [
                    {
                        "name": "#{name}",
                        "organization_name": "#{company}"
                    }
                ]
            }' "https://api.apollo.io/api/v1/people/bulk_match"`
            j = JSON.parse(ret)
            raise "Error: #{j['error_message']}" if j['error_message']
            raise "Error: #{j['error_code']}" if j['error_code']
            raise "Error: #{j['error']}" if j['error']
            match = j['matches'].first
            return nil if match.nil?
            match['email']
        end # def find_person_from_name_and_company

        # Retrieve the email of a person from his name and company.
        #
        # Reference: https://apolloio.github.io/apollo-api-docs/?shell#enrichment-api
        #
        # 
        def find_person_from_name_and_domain(name:, domain:)
            raise 'Error: apollo_apikey or findymail_apikey are required for find_person_from_name_and_domain operation.' if @apollo_apikey.nil? && @findymail_apikey.nil?

            if @findymail_apikey
                ret = `curl --request POST \
                    "https://app.findymail.com/api/search/name" \
                    --header "Authorization: Bearer #{@findymail_apikey}" \
                    --header "Content-Type: application/json" \
                    --header "Accept: application/json" \
                    --data "{
                        \\"name\\": \\"#{name}\\",
                        \\"domain\\": \\"#{domain}\\"
                    }"`
                j = JSON.parse(ret)
                raise "Error: #{j['error']}" if j['error']
                return nil if j['contact'].nil?
                return j['contact']['email']
            elsif @apollo_apikey
                ret = `curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
                    "api_key": "#{@apollo_apikey}",
                    "reveal_personal_emails": true,
                    "details": [
                        {
                            "name": "#{name}",
                            "domain": "#{domain}"
                        }
                    ]
                }' "https://api.apollo.io/api/v1/people/bulk_match"`
                j = JSON.parse(ret)
                raise "Error: #{j['error_message']}" if j['error_message']
                raise "Error: #{j['error_code']}" if j['error_code']
                raise "Error: #{j['error']}" if j['error']
                match = j['matches'].first
                return nil if match.nil?
                return match['email']
            end
        end # def find_person_from_name_and_domain

        # Retrieve the name, job position and email of a person from a list of allowed titles and company domain.
        #
        # Reference: https://apolloio.github.io/apollo-api-docs/?shell#people-api
        #
        # 
        def find_persons_from_title_and_domain(titles:, domain:, limit: 1, calls_delay: 1)
            raise 'Error: apollo_apikey is required for find_persons_from_title_and_domain operation.' if @apollo_apikey.nil?
            b = []

            # search leads
            s = "curl -X POST -H \"Content-Type: application/json\" -H \"Cache-Control: no-cache\" -d '{
                \"api_key\": \"#{@apollo_apikey}\",
                \"page\" : 1,
                \"per_page\": #{limit.to_s},
                \"person_titles\": [\"#{titles.join('", "')}\"],
                \"q_organization_domains\": \"#{domain}\",
                \"contact_email_status\": [\"verified\"]
            }' \"https://api.apollo.io/v1/mixed_people/search\""
            ret = `#{s}`
            j = JSON.parse(ret)
            
            raise "Error: #{j['error_message']}" if j['error_message']
            raise "Error: #{j['error_message']}" if j['error_message']
            raise "Error: #{j['error']}" if j['error']
            
            a = j['people']
            return ret if a.nil?

            a.each { |h|
                # add delay to don't oberload the API
                sleep calls_delay

                i = {}
                i['id'] = h['id']
                i['first_name'] = h['first_name']
                i['last_name'] = h['last_name']
                i['title'] = h['title']
                i['linkedin_url'] = h['linkedin_url']
                i['facebook_url'] = h['facebook_url']

                # find the email of the lead
                s = "curl -X POST -H \"Content-Type: application/json\" -H \"Cache-Control: no-cache\" -d '{
                    \"api_key\": \"#{@apollo_apikey}\",
                    \"reveal_personal_emails\": true,
                    \"id\": \"#{i['id']}\"
                }' \"https://api.apollo.io/v1/people/match\""
                ret = `#{s}`
                j = JSON.parse(ret)

                raise "Error: #{j['error_message']}" if j['error_message']
                raise "Error: #{j['error_code']}" if j['error_code']
                raise "Error: #{j['error']}" if j['error']

                next if j['person'].nil?
                k = j['person'] if j['person']

                # append emails and phone numbers to the hash
                i['emails'] = []
                i['emails'] << k['email'] if k['email']
                i['emails'] += k['personal_emails'] if k['personal_emails']

                i['phone_numbers'] = []
                i['phone_numbers'] = k['phone_numbers'].map { |o| {
                    'value' => o['raw_number'],
                    'type' => o['type']
                } } if k['phone_numbers']

                i['raw'] = k

                b << i
            }

            # return
            b
        end # def find_persons_from_title_and_domain

    end # class Enrichment
end # module BlackStack