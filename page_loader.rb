# Для скачивания страниц нужно использовать библиотеку curb
require 'curb'

class PageLoader
  def initialize(url)
    @url = url
  end

  def page_load
    page = Curl.get(@url)
    page.body_str
  end
  # need to load full page
  # need num of pages
end