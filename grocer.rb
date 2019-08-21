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
    unless cart[item_name] || cart[item_name][:count] <= 0
      next
    else
      if cart[item_name][:count] <= coupon[:num]
        coupons_used = cart[item_name][:count]
        if cart["#{coupon[:item]} W/COUPON"]
          cart[item_name][:count] -= coupons_used
          cart["#{coupon[:item]} W/COUPON"][:price] += coupon[:cost]/coupon[:num]
          cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[item_name][:clearance]
          cart["#{coupon[:item]} W/COUPON"][:count] += coupons_used
          cart[item_name][:count] = 0
          coupon[:num] -= cart[item_name][:count]
        else
          cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost]/coupon[:num], :clearance => cart[item_name][:clearance], :count => coupons_used}
          cart[item_name][:count] = 0
          coupon[:num] -= cart[item_name][:count]

        end
      else
        if cart["#{coupon[:item]} W/COUPON"]
          cart["#{coupon[:item]} W/COUPON"][:price] += coupon[:cost]/coupon[:num]
          cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[item_name][:clearance]
          cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
        else
          cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost]/coupon[:num], :clearance => cart[item_name][:clearance], :count => coupon[:num]}
          cart[item_name][:count] -= coupon[:num]
        end
      end
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
