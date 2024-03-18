require 'pry'

#module BlackStack
    class ApolloClient
        @@apikey = nil

        def initialize(apikey:)
            @apikey = apikey
        end # def initialize

        def get_email(name:, company:)
binding.pry
            ret = `curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
                "api_key": "#{@apikey}",
                "reveal_personal_emails": true,
                "details": [
                    {
                        "linkedin_url": "https://www.linkedin.com/in/richardglapointe"
                    }
                ]
            }' "https://api.apollo.io/api/v1/people/bulk_match"`

=begin
            `
            curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
                "api_key": "#{@@apikey}",
                "reveal_personal_emails": true,
                "details": [
                    {
                        "name": "#{name}",
                        "organization_name": "#{company}",
                        "linkedin_url": "https://www.linkedin.com/in/richardglapointe"
                    },
                    {
                        "first_name": "Roy",
                        "last_name": "Chung",
                        "email": "roy@apollo.io",
                        "hashed_email": "97817c0c49994eb500ad0a5e7e2d8aed51977b26424d508f66e4e8887746a152",
                        "organization_name": "Apollo",
                        "linkedin_url": "http://www.linkedin.com/in/royychung"
                    }
                ]
            }' "https://api.apollo.io/api/v1/people/bulk_match"
            `
=end
        end # def get_email

    end # class ApolloClient
#end # module BlackStack