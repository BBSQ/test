require_relative 'script_status'
require_relative 'page_loader'
require_relative 'category_parser'

class Script
  def initialize(url,file)
    @url = url
    @file = file
      #ScriptStatus.script_start_status
  end

  def run
    CategoryParser.new(PageLoader.new(@url).page_load).parse_pages
  rescue Exception => e
    puts e.message
  end
end