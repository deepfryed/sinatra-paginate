require 'bundler/setup'

require 'nokogiri'
require 'rack/test'
require 'sinatra/paginate'
require 'minitest/autorun'

Struct.new('Result', :total, :size)

class MiniTest::Spec
  include Rack::Test::Methods

  def app &block
    if block
      @app = Class.new(Sinatra::Base) { register Sinatra::Paginate; instance_eval(&block)}
    end
    @app
  end
end
