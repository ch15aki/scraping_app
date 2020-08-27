require 'mechanize'

agent = Mechanize.new
page = agent.get("https://nuxactive.com/collections/shop-all")
elements = page.search('.grid-product__content a')

elements.each do |ele|
  puts ele[:href]
end