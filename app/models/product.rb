# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text(65535)
#  rating        :float(24)
#  number_review :integer
#  category_id   :integer
#  brand_id      :integer
#  shop_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :shop
  has_one :property
  has_many :properties
  has_many :comments
  has_many :order_items

  scope :brand_includes, -> {
    includes(:brand, :shop)
  }
  end
