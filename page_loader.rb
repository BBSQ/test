# Для скачивания страниц нужно использовать библиотеку curb
require 'crub'

class PageLoader
  def initialize(url)
    @url = url
  end

  def page_load
    page = Curl.get(@url)
    page.body_str
  end
end