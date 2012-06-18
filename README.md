# Sinatra Paginate

A simple Sinatra pagination helper.

## Example

```ruby
require 'sinatra/base'
require 'sinatra/paginate'

Struct.new('Result', :total, :size, :tuples)

class MyApp < Sinatra::Base
  register Sinatra::Paginate
  get '/' do
    @result = Struct::Result.new(User.count, 10, User.all(limit: 10, offset: params[:page].to_i * 10)
    haml :index
  end
end
```

```haml
-# views/index.haml

%ul
  - @result.tuples.each do |user|
    %li
      %span= user.id
      %span= user.name

= paginate @result
```
# License
[Creative Commons Attribution - CC BY](http://creativecommons.org/licenses/by/3.0)
