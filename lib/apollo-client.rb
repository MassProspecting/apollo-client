#module BlackStack
    class ApolloClient
        @apikey = nil

        def initialize(apikey:)
            @apikey = apikey
        end
    end # class ApolloClient
#end # module BlackStack