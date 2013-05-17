# encoding: utf-8
require 'sinatra/base'
require 'uri'

module Sinatra
  module Paginate
    DEFAULTS = {items_per_page: 10, width: 5, renderer: 'haml', labels: {first: '«', last: '»'}}

    def paginate resource, options = {}
      raise ArgumentError, 'resource should respond to :total' unless resource.respond_to?(:total)
      raise ArgumentError, 'resource should respond to :size'  unless resource.respond_to?(:size)

      options  = DEFAULTS.merge(options)
      view     = options.fetch(:view, paginate_haml)
      renderer = options.fetch(:renderer)
      send(renderer, view, layout: false, locals: paginate_options(resource, options))
    end

    def paginate_options resource, options
      last = (resource.total / options[:items_per_page].to_f).ceil
      page = [1, params['page'].to_i].max
      from = [1, page - (options[:width] >> 1)].max
      to   = [from + options[:width] - 1, last].min

      while (to - from + 1) < options[:width] && (to < last || from > 1)
        to   += 1 if to   < last
        from -= 1 if from > 1
      end
      {page: page, from: from, to: to, last: last, uri: options.fetch(:uri, request.path_info), labels: options.fetch(:labels)}
    end

    def paginate_haml
      @@haml ||= File.read(__FILE__).sub %r{^.*__END__}m, ''
    end

    def page
      page = params['page'].to_i
      page > 0 ? page : 1
    end

    def pagination_url *path
      params = path[-1].respond_to?(:to_hash) ? path.delete_at(-1).to_hash : {}
      params = params.empty? ? '' : '?' + URI.escape(params.map{|*a| a.join('=')}.join('&')).to_s
      ['/', path.compact.map(&:to_s)].flatten.join('/').gsub(%r{/+}, '/') + params
    end

    def self.registered app
      app.helpers self
    end
  end # Paginate

  register Paginate
end # Sinatra

__END__
:css
  ul.sinatra-pagination > li {
    float: left;
    margin-right: 10px;
    display: inline-block;
    list-style-type: none;
  }

- pagination_css = {-1 => 'btn-prev', 1 => 'btn-next', 0 => 'btn-primary'}
%ul.sinatra-pagination
  %li
    %a.btn.btn-first{href: pagination_url(uri, params.merge('page' => 1))}= labels[:first]
  - (from..to).each do |n|
    %li
      %a{href: pagination_url(uri, params.merge('page' => n)), class: "btn #{pagination_css[n - page]}"}= n
  %li
    %a.btn.btn-last{href: pagination_url(uri, params.merge('page' => last))}= labels[:last]
