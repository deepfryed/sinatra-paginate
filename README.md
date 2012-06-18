# Sinatra Paginate

A simple Sinatra pagination helper.

## Example

```ruby
require 'sinatra/base'
require 'sinatra/paginate'

Struct.new('Result', :total, :size, :users)

class MyApp < Sinatra::Base
  register Sinatra::Paginate

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
```

```haml
-# views/index.haml

%ul
  - @result.users.each do |user|
    %li
      %span= user.id
      %span= user.name

= paginate @result
```

## Sample Sinatra Application

```
bundle
cd example/
bundle exec rackup -p 3000
```

# License
[Creative Commons Attribution - CC BY](http://creativecommons.org/licenses/by/3.0)
