class Scraping
  def self.nux_urls
    links = []
    agent = Mechanize.new

    next_url = "/collections/shop-all"

    while true do 
      current_page = agent.get("https://nuxactive.com" + next_url)
      elements = current_page.search('.grid-product__content a')
  
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pagination .next a')
      break unless  next_link

      next_url = next_link[:href]
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
  product = Product.where(name: name).first_or_initialize
  product.price = price
  product.image_url = image_url
  product.save
  end
end