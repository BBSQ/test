require_relative 'result_file_writer'
require_relative 'product'
require_relative 'page_loader'
require_relative 'url_builder'

class ProductParser
  def initialize(product_page)
    @product_page = product_page
  end

  def parse_page
    n = 0
    i = 0
    images_collected = false
    tempQuantity = []
    tempPrice = []
    tempImage = []
    tempName = @product_page.xpath('//h1[@class="product_main_name"]').text.strip
    if @product_page.xpath('//span[@class="radio_label"]').text.strip == "" # Если нету весовки/кол-ва/размера
      tempQuantity << "" # пустая строка
      tempPrice << @product_page.xpath('//span[@id="our_price_display"]').text.strip # общая цена продукта
      tempImage << @product_page.xpath('//img[@id="bigpic"]/@src').text.strip
    else # В противном случае (если значение весовки есть и/или оно не одно)
      loop do
        if n >= 1 # Если значение весовки не одно (Мультипродукт?)
          if @product_page.xpath('//label[@class="attribute_label new-label-group l-caracteristicas"]')[1].nil? # Мультипродукт
            if images_collected != true
              loop do # * Ссылки на картинки могут быть разными у разных вариаций (не работает, зато имититрует работу реального пользователя с сайтом)
                main_link = @product_page.xpath('//link[@hreflang="x-default"]/@href')
                code_part = @product_page.xpath('//input[@type="radio"]/@value')[i+2] # 2349
                parameter_part = @product_page.xpath('//label[@class="attribute_label new-label-group l-caracteristicas"]').text.strip.gsub(/ñ/,"n").chop # UNIDADES
                quantity_part = @product_page.xpath('//span[@class="radio_label"]')[i].text.strip # 5 unidades x 115Grs
                multi_url = URLBuilder.new(main_link, code_part, parameter_part, quantity_part).build_url
                tempImage[i] = Nokogiri::HTML(PageLoader.new(multi_url).page_load('multi-product')).xpath('//img[@id="bigpic"]/@src').text.strip
                i += 1
                if @product_page.xpath('//span[@class="radio_label"]')[i].nil?
                  images_collected = true
                  break
                end
              end
            end
          end
        end
        # Сначала это
        tempQuantity << @product_page.xpath('//span[@class="radio_label"]')[n].text.strip
        tempPrice << @product_page.xpath('//span[@class="price_comb"]')[n].text.strip
        if n == 0 # Получение картинки Монотовара
          tempImage << @product_page.xpath('//img[@id="bigpic"]/@src').text.strip
        end
        n += 1
        if @product_page.xpath('//span[@class="radio_label"]')[n].nil?
          break
        end
      end
    end
    puts Time.now.to_s + ": Making Hash."
    args = {
        name: tempName,
        quantity: tempQuantity,
        price: tempPrice,
        image: tempImage
    }
    Product.new(args)
  end
end