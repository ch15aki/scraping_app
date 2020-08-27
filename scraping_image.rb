require 'mechanize'

#new一覧ページからimgを取得
# agent = Mechanize.new
# page = agent.get("https://www.bombshellsportswear.com/collections/new")
# elements = page.search(".product img")

# elements.each do |ele|
#   puts ele.get_attribute('src') # get_attributeメソッドで属性srcの値を取得
# end

# 個別ページのproduct画像のURLを取得
# agent = Mechanize.new
# page = agent.get("https://www.bombshellsportswear.com/products/all-star-thigh-highs")
# ele = page.at(".product-default img")
# puts ele.get_attribute('src')

#new一覧ページから個別リンクを取得し、画像のURLを取得
def scraping_image(link)
  agent = Mechanize.new
  page = agent.get(link)
  image_url = page.at('.product-default img').get_attribute('src')
  return "https:#{image_url}"
end

links = [] # 個別ページのリンクを保存する配列
agent = Mechanize.new
current_page = agent.get("https://www.bombshellsportswear.com/collections/new")
elements = current_page.search('.product-info a')
elements.each do |ele|
  links << ele.get_attribute('href')
end

links.each do |link|
  puts scraping_image("https://www.bombshellsportswear.com" + link)
end