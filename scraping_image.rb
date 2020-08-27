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
  name = page.at('h1').inner_text
  price = page.at('.product__price').inner_text
  image_url = page.at('.MagicToolboxSlide img')[:src] if page.at('.MagicToolboxContainer img')
end

#①linksという配列の空枠を作る
links = []
#②Mechanizeクラスのインスタンスを生成する
agent = Mechanize.new
#③nuxの全体ページのURLを取得
current_page = agent.get("https://nuxactive.com/collections/shop-all")
#④全体ページからnuxの個別URLのタグを取得
elements = current_page.search('.grid-product__content a')
#⑤個別URLのタグからhref要素を取り出し、links配列に格納する
elements.each do |ele|
  links << ele.get_attribute('href')
end

links.each do |link|
  puts scraping_image('https://nuxactive.com' + link)
end