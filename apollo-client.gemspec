Gem::Specification.new do |s|
    s.name        = 'apollo-client'
    s.version     = '1.0.4'
    s.date        = '2025-01-08'
    s.summary     = "Ruby library for connecting some enrichment services like Apillo."
    s.description = "Ruby library for connecting some enrichment services like Apillo."
    s.authors     = ["Leandro Daniel Sardi"]
    s.email       = 'leandro@connectionsphere.com'
    s.files       = [
      'lib/blackstack-enrichment.rb',
      'blackstack-enrichment.gemspec'
    ]
    s.homepage    = 'https://github.com/leandrosardi/blackstack-enrichment'
    s.license     = 'MIT'
    s.add_runtime_dependency 'json', '~> 2.6.3', '>= 2.6.3'
end
