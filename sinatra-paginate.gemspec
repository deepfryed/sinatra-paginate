# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra-paginate"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bharanee Rathna"]
  s.date = "2012-06-18"
  s.description = "Simple Sinatra pagination helper."
  s.email = ["deepfryed@gmail.com"]
  s.files = ["test/helper.rb", "test/test_haml.rb", "lib/sinatra/paginate.rb", "README.md", "Gemfile", "Gemfile.lock", "CHANGELOG"]
  s.homepage = "http://github.com/deepfryed/sinatra-paginate"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Sinatra pagination helper."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
  end
end
