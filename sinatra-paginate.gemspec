# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra-paginate"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bharanee Rathna", "Nika Miller"]
  s.date = "2014-02-12"
  s.description = "Simple Sinatra pagination helper, modified to work with Ruby 1.8.7 and erb."
  s.email = ["miller.nika@gmail.com"]
  s.files = ["test/helper.rb", "test/test_haml.rb", "lib/sinatra/paginate.rb", "lib/sinatra/views/pagination_nav.erb", "lib/sinatra/views/pagination_nav.haml", "README.md", "Gemfile", "Gemfile.lock", "CHANGELOG"]
  s.homepage = "http://github.com/nika-m/sinatra-paginate"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Sinatra Pagination Helper."

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
