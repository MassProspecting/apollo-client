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
            raise 'Error: apollo_apikey is required for find_person_from_linkedin_url operation.' if @apollo_apikey.nil?

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
            raise 'Error: apollo_apikey or findymail_apikey are required for find_person_from_linkedin_url operation.' if @apollo_apikey.nil? && @findymail_apikey.nil?

            if @findymail_apikey
                ret = `curl --request POST \
                    "https://app.findymail.com/api/search/name" \
                    --header "Authorization: Bearer #{@findymail_apikey}" \
                    --header "Content-Type: application/json" \
                    --header "Accept: application/json" \
                    --data \"{
                        \"name\": \"#{name}\",
                        \"domain\": \"#{domain}\"
                    }\"`
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
                match = j['matches'].first
                return nil if match.nil?
                return match['email']
            end
        end # def find_person_from_name_and_website

    end # class Enrichment
end # module BlackStack