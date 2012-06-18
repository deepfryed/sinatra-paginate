# encoding: utf-8

$:.unshift File.dirname(__FILE__) 

require 'date'
require 'pathname'
require 'rake'
require 'rake/testtask'

$rootdir = Pathname.new(__FILE__).dirname
$gemspec = Gem::Specification.new do |s|
  s.name                      = 'sinatra-paginate'
  s.version                   = '0.1.0'
  s.authors                   = ['Bharanee Rathna']
  s.email                     = ['deepfryed@gmail.com']
  s.summary                   = 'Sinatra pagination helper.'
  s.description               = 'Simple Sinatra pagination helper.'
  s.homepage                  = 'http://github.com/deepfryed/sinatra-paginate'
  s.date                      = Date.today
  s.require_paths             = %w(lib)
  s.files                     = Dir['{test,lib}/**/*.rb'] + %w(README.md Gemfile Gemfile.lock CHANGELOG)

  s.add_dependency             'sinatra'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rack-test'
end

desc 'Generate gemspec'
task :gemspec do 
  $gemspec.date = Date.today
  File.open("#{$gemspec.name}.gemspec", 'w') {|fh| fh.write($gemspec.to_ruby)}
end

Rake::TestTask.new(:test) do |test|
  test.libs   << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task default: :test
