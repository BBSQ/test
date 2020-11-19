require 'nokogiri' # для парсинга страниц ​ nokogiri​
require_relative 'product_parser'

class CategoryParser
  def initialize(page)
    @page = page
  end

  def parse_pages
    doc = Nokogiri::HTML(@page)
    puts Time.now.to_s + ": Parsing of category for URL of products."
    product_urls = doc.xpath('.//a[@class="product-name"]/@href')
    puts Time.now.to_s + ": There are [#{product_urls.size}] products in the current category."
    n = 1
    parsed_products = []
    product_urls.each do |url|
      puts url
      product_page = Nokogiri::HTML(PageLoader.new(url).page_load("[#{n}] product"))
      puts Time.now.to_s + ": Parsing of product[#{n}] for title (with weight), price and image."
      n += 1
      parsed_products << ProductParser.new(product_page).parse_page
    end
    parsed_products
  end
end