class URLBuilder
  def initialize(url, code, parameter, quantity)
    @url = url
    @code = code
    @parameter = parameter
    @quantity = quantity
  end

  def build_url
    "#{@url}#/#{@code}-#{@parameter.gsub(/ /,"_").downcase}-#{@quantity.gsub(/"."/,"_").gsub(/ /,"_").gsub("(","").gsub(")","").downcase}"
  end

end