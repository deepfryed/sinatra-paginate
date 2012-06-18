require 'sinatra/base'
require 'sinatra/paginate'
require 'active_record'

Struct.new('Result', :total, :size, :users)

class User < ActiveRecord::Base; end

class App < Sinatra::Base
  register Sinatra::Paginate

  # sample data
  before do
    ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
    ActiveRecord::Schema.define do
      execute 'drop table if exists users'
      create_table :users do |t|
        t.column :name, :string
      end

      120.times do |n|
        User.create(name: "user #{n + 1}")
      end
    end
  end

  helpers do
    def page
      [params[:page].to_i - 1, 0].max
    end
  end

  get '/' do
    @users  = User.all(limit: 10, offset: page * 10)
    @result = Struct::Result.new(User.count, @users.count, @users)
    haml :index
  end
end
