class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"] #searching our url
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty? #checks if cart is empty
        resp.write "Your cart is empty"
      else req.path.match(/cart/) #if cart not empty create a list
        @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end
    end
    elsif req.path.match(/add/) #add an item to the cart
        item_instance = req.params["item"]
        if @@items.include?(item_instance)
          @@cart << item_instance
          resp.write "added #{item_instance}"
        else
          resp.write "We don't have that item"
        end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
