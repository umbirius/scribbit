class ReviewsController < ApplicationController
    def index 

    end

    def new 
        @review = Review.new
    end

    def create
        byebug
        @review = current_user.build(review_params)
    end

end
