class Scraping
  def self.product_urls
    #①linksという配列の空枠を作る
    links = []
    #②Mechanizeクラスのインスタンスを生成する
    agent = Mechanize.new
    #③product(tops)の全体ページのURLを取得
    current_page = agent.get("https://www.bombshellsportswear.com/collections/all-tops")
    #④全体ページからproducts12件の個別URLのタグを取得
    elements = current_page.search(".product-info a")
    #⑤個別URLのタグからhref要素を取り出し、links配列に格納する
    elements.each do |ele|
      links << ele.get_attribute('href')
    end
    #⑥get_productを実行する際にリンクを引数として渡す
    links.each do |link|
      get_product('https://www.bombshellsportswear.com/' + link)
    end
  end

  def self.get_product(link)
    #⑦Mechanizeクラスのインスタンスを生成する
    agent = Mechanize.new
    #⑧productの個別ページのURLを取得
    page = agent.get(link)
    #⑨inner_textメソッドを利用し映画のタイトルを取得
    name = page.at('h1').inner_text
    # ⑪priceの取得
    price = page.at('.product-price span').inner_text
    #⑫image_urlがあるsrc要素のみを取り出す
    image_url = page.at('.product-default a')[:src] if page.at('.product-default a')
    #①①newメソッド、saveメソッドを使い、 スクレイピングした「商品名」「価格」と「商品画像のurl」をproductsテーブルに保存
    product = Product.where(name: name, price: price, image_url: image_url).first_or_initialize
    product.save
  end
end