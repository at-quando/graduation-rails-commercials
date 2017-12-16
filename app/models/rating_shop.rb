class RatingShop < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  
  def calculate_rating_shop
    return quality*0.5 + warranty*0.2 + delivery*0.2 + service*0.1
  end
end
