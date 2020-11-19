require_relative 'page_loader'
require_relative 'category_parser'

class Script
  def initialize(url)
    @url = url
  end

  def run
    puts Time.now.to_s + ": Script started."
    CategoryParser.new(PageLoader.new(@url).full_page_load).parse_pages
  end
end