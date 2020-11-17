class Product
  attr_accessor :name, :price, :image, :product_code

  def initialize(args)
    @name = args[:name]
    @weight = args[:weight]
    @price = args[:price]
    @image = args[:image]
  end

end