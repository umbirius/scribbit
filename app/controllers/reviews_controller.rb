class ReviewsController < ApplicationController
    def index 

    end

    def new 
        @review = Review.new
    end

    def create
        byebug
        @review = current_user.requested_reviews.build()
        @project = Project.find_by(title: params[:review][:project])
        @review.project = @project
        @review.save
        redirect_to reviews_path
    end

    private 

    def review_params
        params.require(:review).permit()
    end 

end
