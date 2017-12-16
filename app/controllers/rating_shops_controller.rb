class RatingShopsController < ApplicationController
  def create
    @rating=RatingShop.where(user_id: params[:user_id], shop_id: params[:shop_id])
    @shop = Shop.find(params[:shop_id])
    if @rating.length == 0
      @review = RatingShop.new( user_id: params[:user_id],
                                shop_id: params[:shop_id],
                                quality: params[:obj_rating][:quality],
                                warranty: params[:obj_rating][:warranty],
                                delivery: params[:obj_rating][:delivery],
                                service: params[:obj_rating][:service],
                                review_shop: params[:review]
                              )
      if @review.save && @review.update(total: @review.calculate_rating_shop)
        cal = @shop.calculate_rating(@review.total)
        num = @shop.number_review + 1
        @shop.update(rating: cal, number_review: num)
        render json: { status: 'created ok' }
      else
        render json: { error: 'Failed Created Rating Shop' }
      end
    else
      old_rate = @rating[0].total
      @rating[0].update(  quality: params[:obj_rating][:quality],
                          warranty: params[:obj_rating][:warranty],
                          delivery: params[:obj_rating][:delivery],
                          service: params[:obj_rating][:service],
                          review_shop: params[:review])
      @rating[0].update(total: @rating[0].calculate_rating_shop)
      binding.pry
      @shop.update(rating: @shop.update_rating(old_rate, @rating[0].total))
      render json: { status: 'update ok' }
    end
  end

  def review_shop
    @rating = RatingShop.where(shop_id: params[:id])
    render json: @rating, include: [:user]
  end
end
