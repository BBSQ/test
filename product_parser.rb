require_relative 'product'
class ProductParser
  def initialize(product_page)
    @args =[]
    @product_page = product_page
  end
# need multiproduct logic
  def parse_page
    tempName = @product_page.xpath('//h1[@class="product_main_name"]').text.strip
    tempPrice = @product_page.xpath('//span[@id="our_price_display"]').text.strip
    tempWeight = @product_page.xpath('//span [@class="radio_label"]').text.strip
    tempImage = @product_page.xpath('//img [@id="bigpic"]/@src').text.strip
    @args.push(
        name: tempName,
        weight: tempWeight,
        price: tempPrice,
        image: tempImage
    )
      #Product.new(@args)
  end
end