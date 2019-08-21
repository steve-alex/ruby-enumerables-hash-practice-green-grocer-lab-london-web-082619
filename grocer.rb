def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item.each do |name, info|
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = info
        new_cart[name][:count] = 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]

    if cart.has_key?(item_name)
      cart[item_name][:count] -= coupon[:num]
      cart["#{coupon[:item]} W/COUPON"] = {:price => 0, :clearance => true, :count => 0}
      cart["#{coupon[:item]} W/COUPON"][:price] += coupon[:cost]/coupon[:num]
      cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
    else
      next
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] *= 0.8
      info[:price] = info[:price].round(1)
    else
      next
    end
  end
  cart
end

def checkout(cart, coupons)
  
end
