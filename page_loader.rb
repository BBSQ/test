require 'curb' # Для скачивания страниц нужно использовать библиотеку curb

class PageLoader
  def initialize(url)
    @url = url
  end

  def page_load(type) # Обычная загрузка страницы
    puts Time.now.to_s + ": Downloading of " + type + " page..."
    page = Curl.get(@url)
    page.body_str
  end

  def num_page_load(n) # Загрузка страницы по номеру
    page = Curl.get(@url + "?p=#{n}")
    page.body_str
  end


  def full_page_load # Сборка всей страницы (всё в кучу)
    n = 2

    full_page = page_load("category") # Первая страница категории
    if num_page_load(n) != num_page_load(n+1) # Если страниц несколько
      loop do
        puts Time.now.to_s + ": Downloading of category page[#{n}]..."
        full_page += num_page_load(n)
        n += 1
        if num_page_load(n) == num_page_load(n+1)
          break
        end
      end
    end
    full_page
  end

end