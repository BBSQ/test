# для парсинга страниц ​ nokogiri​
require 'nokogiri'
require_relative 'product_parser'
class CategoryParser
  def initialize(page)
    @page = page
  end

  def parse_pages
    doc = Nokogiri::HTML(@page)
    product_urls = doc.xpath('.//a[@class="product-name"]/@href')
    puts product_urls.size
    product_urls.each do |url|
      puts url
      product_page = Nokogiri::HTML(Curl.get(url).body_str)
      puts ProductParser.new(product_page).parse_page
    end
  end
end