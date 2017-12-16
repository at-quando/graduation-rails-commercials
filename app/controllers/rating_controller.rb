class RatingController < ApplicationController
  before_action :perform_authorization, only: [:update]
  def update
    product = Product.find(params[:id])
    number_review = product.number_review + 1
    new_rating = ((product.rating * product.number_review + params[:rating].to_i) / number_review.to_f)
    if product.update(number_review: number_review, rating: new_rating)
      render json: product
    else
      render json: { error: 'Failed' }
    end
  end

  def create
    product = Product.find(params[:product_id])
    @rating = Rating.find_by(user_id: params[:user_id], product_id: params[:product_id])
    if @rating != nil
      new_rating = (product.rating * product.number_review - @rating.rate + params[:rating].to_i)/ product.number_review.to_f
      if product.update(rating: new_rating)
        @rating.update(rate: params[:rating])
        render json: { point: params[:rating].to_s }
      else
        render json: { error: 'Failed Updated' }
      end
    else
      number_review = product.number_review + 1
      new_rating = ((product.rating * product.number_review + params[:rating].to_i) / number_review.to_f)
      @stat = Statistic.all[0]
      if Statistic.update_all("all_reviews = all_reviews + 1") && product.update(number_review: number_review, rating: new_rating, ranking: @stat.calculate_ranking(product.number_review, product.rating))
        Rating.create(user_id: params[:user_id], product_id: params[:product_id], rate: params[:rating])
        render json: { point: params[:rating].to_s }
      else
        render json: { error: 'Failed Created' }
      end
    end
  end
end
