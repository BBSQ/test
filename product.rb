class Product
  attr_accessor :name, :quantity, :price, :image

  def initialize(args)
    @name = args[:name]
    @quantity = args[:quantity]
    @price = args[:price]
    @image = args[:image]
  end
end