require 'mechanize'

agent = Mechanize.new
page = agent.get("https://www.bombshellsportswear.com/collections/new")
elements = page.search('.product-details h2')

elements.each do |ele|
  puts ele.inner_text
end