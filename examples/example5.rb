# Create a file `config.rb` in the $RUBYLIB directory.
# Define the constant APOLLO_API_KEY there.
#

require 'pry'
require 'simple_cloud_logging'
require_relative '../config'
require_relative '../lib/apollo-client'
require 'colorize'

# 
l = BlackStack::LocalLogger.new('examples.log')

# leads scraped from Sales Navigator with the following data-points: 
# - first name
# - last name
# - job title
# - company name
#
a = [
  { first_name: "Raheem", last_name: "Dawar", job_title: "CEO & Founder", company_name: "Codieshub" },
  { first_name: "Dana", last_name: "Watkins", job_title: "Director of M&A", company_name: "Align Business Advisory Services" },
  { first_name: "Victoria", last_name: "Moser", job_title: "Director of Events and Community Partnerships", company_name: "South Florida Tech Hub 🌴" },
  { first_name: "Keren", last_name: "de Via", job_title: "Chief Operating Officer", company_name: "Cyturus Technologies, Inc." },
  { first_name: "Craig", last_name: "Gillan", job_title: "Advisor", company_name: "iROCKER Inc" },
  { first_name: "Dom", last_name: "LeRoux", job_title: "Marketing Manager", company_name: "BioProtein Technology" },
  { first_name: "Greg", last_name: "Shugar", job_title: "Investor, Advisor and Board Member", company_name: "Eighty One Int'l Inc. dba Carrie Amber Intimates" },
  { first_name: "Shawn", last_name: "Simao", job_title: "Chief Financial Officer", company_name: "MVP Task Force" },
  { first_name: "Ross", last_name: "Statham", job_title: "", company_name: "" },
  { first_name: "Dylan", last_name: "Huberman", job_title: "Public Information Manager", company_name: "Boca Raton Police Department" },
  { first_name: "Clifford", last_name: "Gray", job_title: "Customer Relationship Management Business Analyst", company_name: "Technology Advisors, Inc." },
  { first_name: "Juan Manuel", last_name: "Chacin", job_title: "Business Development Director for Corporate Work Study Partners", company_name: "Cristo Rey Miami High School" },
  { first_name: "Donoven", last_name: "Van Der Merwe", job_title: "Sales Broker", company_name: "YACHTZOO" },
  { first_name: "Cinzia", last_name: "Amadio", job_title: "Chief Marketing and Growth Officer", company_name: "ROAR AFRICA" },
  { first_name: "Christopher", last_name: "Usher", job_title: "Security, Emergency Preparedness, Risk Assessment Subject Matter Expert, Consultant and Trainer", company_name: "DPREP Safety Division" },
  { first_name: "Yaakov", last_name: "Werdiger", job_title: "Consultant", company_name: "Doroni Aerospace" },
  { first_name: "Arthur", last_name: "Rattray", job_title: "Sales Consultant", company_name: "Verde Solutions" },
  { first_name: "Tony", last_name: "DiSanza", job_title: "Chief Revenue Officer", company_name: "SimplAI" },
  { first_name: "Jesse", last_name: "Higgins", job_title: "Builder Development Representative", company_name: "DRIRITE Of Hillsborough County" },
  { first_name: "Raymond", last_name: "Shiver", job_title: "Sales Representative", company_name: "American Glass Professionals" },
  { first_name: "Paul", last_name: "McCarthy", job_title: "Sales Director", company_name: "Hero Facility Services" },
  { first_name: "Matthew", last_name: "Mader", job_title: "Director of Digital Marketing Strategy", company_name: "Mark My Words Media" },
  #{ first_name: "Nick", last_name: "Gobora", job_title: "", company_name: "" },
  { first_name: "John", last_name: "Watson", job_title: "Television News Producer", company_name: "Action News Jax" },
  { first_name: "Ricardo", last_name: "Bravo Vargas", job_title: "Miembro de la Junta Directiva", company_name: "Cámara de Comercio de Maracaibo CCM" }
]

# array of hashes of Apollo's descriptor
b = []

# Apollo client
client = ApolloClient.new(
    apollo_apikey: APOLLO_API_KEY,
    #findymail_apikey: FINDYMAIL_API_KEY,
)

# 
x = 0
a.each { |h| 
    x += 1
    l.logs "#{x}. #{h[:first_name]} #{h[:last_name]}... "
sleep(1)
    # 
    json = client.find_person_from_name_and_company(
        name: "#{h[:first_name]} #{h[:last_name]}", 
        company: h[:company_name], 
        return_only_email: false,
        reveal_personal_emails: false
    )

    # Detect if the has changd job recently
    just_resigned_jobs = []
    if json && json['employment_history']
        just_resigned_jobs = json['employment_history'].select { |i| 
            i['current'] == false &&
            Date.parse(i["end_date"]) > (Date.today << 12)
        }
    end        
    n = just_resigned_jobs.size

    l.done(details: "#{n == 0 ? '0'.yellow : n.to_s.green} jobs resigned" )
}



