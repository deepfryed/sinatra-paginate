# encoding: utf-8
require 'sinatra/base'
require 'uri'

module Sinatra
  module Paginate
    DEFAULTS = {:items_per_page => 20, :width => 5, :renderer => 'erubis', :labels => {:first => '«', :last => '»'}}

    def paginate resource, options = {}
      raise ArgumentError, 'resource should respond to :total' unless resource.respond_to?(:total)
      raise ArgumentError, 'resource should respond to :size'  unless resource.respond_to?(:size)

      options  = DEFAULTS.merge(options)
      view     = options.fetch(:view, paginate_erb)
      renderer = options.fetch(:renderer)
      send(renderer, view, :layout => false, :locals => paginate_options(resource, options))
    end

    def paginate_options resource, options
      last = (resource.total / options[:items_per_page].to_f).ceil
      page = [1, params[:page].to_i].max
      from = [1, page - (options[:width] >> 1)].max
      to   = [from + options[:width] - 1, last].min

      while (to - from + 1) < options[:width] && (to < last || from > 1)
        to   += 1 if to   < last
        from -= 1 if from > 1
      end

      {:page => page, :from => from, :to => to, :last => last, :uri => options.fetch(:uri, request.path_info), :labels => options.fetch(:labels)}
    end

    def paginate_haml
      @@haml ||= File.read(File.join(File.dirname(__FILE__), 'views', 'pagination_nav.haml'))
    end

    def paginate_erb
      @@erubis ||= File.read(File.join(File.dirname(__FILE__), 'views', 'pagination_nav.erb'))
    end

    def page
      page = params[:page].to_i
      page > 0 ? page : 1
    end

    def offset_value items_per_page
      (page * items_per_page) - items_per_page
    end

    def viewing_text offset, total, items_per_page
      from_this = total == 0 ? offset : offset + 1
      to_that = (offset + items_per_page) > total ? total : (offset + items_per_page)
      "#{from_this} - #{to_that} of #{total}"
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
