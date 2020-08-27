class Scraping
  def self.nux_urls
    links = []
    agent = Mechanize.new
    current_page = agent.get("https://nuxactive.com/collections/shop-all")
    elements = current_page.search('.grid-product__content a')

    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    links.each do |link|
      get_nux("https://nuxactive.com" + link)
    end
  end

  def self.get_nux(link)
  agent = Mechanize.new
  page = agent.get(link)
  name = page.at('h1').inner_text
  price = page.at('.product__price').inner_text
  url = page.at('.MagicToolboxSlide img')[:src] if page.at('.MagicToolboxContainer img')
  image_url = "https:#{url}"
  product = Product.where(name: name, price: price, image_url: image_url).first_or_initialize
  product.save
  end
end