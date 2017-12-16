class HomeProductsController < ApplicationController
  def sale_products
    product = Product.where(id: Property.select(:product_id).where('id in (?)',Discount.select(:property_id).order(sale: 'desc').limit(4).map(&:property_id)).map(&:product_id))
    render json: product, each_serializer: Product::DetailSerializer, include: [:shop, :properties, :category, { properties: :images }]
  end

  def high_rate_products
    product = Product.where("number_review> 50").order(rating: 'desc').limit(4)
    render json: product, each_serializer: Product::DetailSerializer, include: [:shop, :properties, :category, { properties: :images }]
  end

  def most_buy_products
    product = Product.where(id: Property.select(:product_id).where(id: OrderItem.select('property_id, COUNT(*) as quantity').group(:property_id).order("quantity desc").limit(4).map(&:property_id)).map(&:product_id))
    render json: product, each_serializer: Product::DetailSerializer, include: [:shop, :properties, :category, { properties: :images }]
  end
end
