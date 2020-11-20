require 'csv'

class ResultFileWriter
  def initialize(parsed_products, file)
    @parsed_products = parsed_products
    @file = file
  end

  def write_to_csv
    p = 0
    CSV.open(@file, "w") do |csv|
      @parsed_products.map do |product|
        n = 0
        if product.name != ""
          until n == product.price.size
            p = p + 1
            if product.price[n] == product.price[n+1]
              csv << ["Record № #{p})"]
              csv << ["title: #{product.name} #{product.quantity[n]} #{product.quantity[n+1]}"]
              csv << ["price: #{product.price[n]}"]
              csv << ["image: #{product.image[n]}"]
              n += 1
            else
              csv << ["Record № #{p})"]
              csv << ["title: #{product.name} #{product.quantity[n]}"]
              csv << ["price: #{product.price[n]}"]
              csv << ["image: #{product.image[n]}"]

            end
            n += 1
          end
        end
      end
    end
    puts Time.now.to_s + ": Script ended."
    check_file
  end

  def check_file
    if File.file?(@file)
      puts Time.now.to_s + " #{@file} updated"
    end
  end
end