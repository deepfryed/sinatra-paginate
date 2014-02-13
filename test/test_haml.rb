# encoding: utf-8
require 'test/helper'

describe 'haml pagination' do
  before do
    app do
      get '/' do
        paginate Struct::Result.new(60, 5), :items_per_page => 5
      end
    end
  end

  def pagination_li
    Nokogiri::HTML(last_response.body).css('ul.sinatra-pagination > li')
  end

  def status
    last_response.status
  end

  def pagination_current
    pagination_li.at('.btn-primary').parent
  end

  it 'should render pagination' do
    get '/'
    assert_equal 200,  status
    assert_equal 7,    pagination_li.count # first, 1..5, last
    assert_equal '1',  pagination_current.text.strip
    assert_equal '«',  pagination_li.at('.btn-first').text
    assert_equal '»',  pagination_li.at('.btn-last').text
  end

  it 'should paginate to page 2' do
    get '/', :page => 2
    assert_equal 200,         status
    assert_equal '2',         pagination_current.text.strip
    assert_equal '/?page=1',  pagination_li.at('.btn-first')['href']
    assert_equal '/?page=12', pagination_li.at('.btn-last')['href']
    assert_equal %w(« 1 2 3 4 5 »), pagination_li.map {|li| li.text.strip}
  end

  it 'should paginate to page n' do
    get '/', :page => 5
    assert_equal 200, status
    assert_equal '5', pagination_current.text.strip
    assert_equal %w(« 3 4 5 6 7 »), pagination_li.map {|li| li.text.strip}
  end
end
