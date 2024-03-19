Gem::Specification.new do |s|
    s.name        = 'blackstack-enrichment'
    s.version     = '1.0.1'
    s.date        = '2024-03-19'
    s.summary     = "Ruby library for connecting some enrichment services like Apillo or FindyMail."
    s.description = "Ruby library for connecting some enrichment services like Apillo or FindyMail."
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