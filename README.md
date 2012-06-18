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

!= paginate @result, items_per_page: 10, labels: {first: '«', last: '»'}, renderer: 'haml'
```

## Sample Sinatra Application

```
bundle
cd example/
bundle exec rackup -p 3000
```

## Options

```
* renderer         # rendering engine to use (default: haml)
* view             # override default view and use custom one
* items_per_page   # maximum items per page (default: 10)
* uri              # base pagination uri (defaults: request.path_info)
* width            # number of pagination buttons (default: 5)
* labels           # text labels for first & last buttons (default: {first: '«', last: '»'})
```

# License
[Creative Commons Attribution - CC BY](http://creativecommons.org/licenses/by/3.0)
