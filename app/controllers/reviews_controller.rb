class ReviewsController < ApplicationController

  def create
    description = params["description"]
    rating = params["review"]["rating"]
    product_id = params["product_id"]
    user_id = session[:user_id]

    @review = Review.new(
      description: description, 
      rating: rating, 
      product_id: product_id,
      user_id: user_id
    )
    @review.save
    redirect_to :back
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to :back    
  end

end
