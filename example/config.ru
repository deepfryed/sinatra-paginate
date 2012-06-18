$:.unshift File.dirname(__FILE__)
$:.unshift File.dirname(__FILE__) + '/../lib'

require 'bundler/setup'
require 'app'

run App
