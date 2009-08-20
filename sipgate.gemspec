
Gem::Specification.new do |s|
  s.name = %q{sipgate}
  s.version = "0.0.1"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corny", "Averell"]
  s.date = %q{2009-08-21}
  s.description = %q{send fax through sipgate and check their sending status.}
  s.email = %q{mail@digineo.de}
  s.files = %w(
    MIT-LICENSE
    README.rdoc
    init.rb
    lib/sipgate.rb
    lib/response.rb
    lib/error.rb
  )
  s.has_rdoc = true
  s.homepage = %q{http://github.com/corny/sipgate}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
end