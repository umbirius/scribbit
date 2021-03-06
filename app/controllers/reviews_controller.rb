class ReviewsController < ApplicationController
    def index 
        @sub_reviews = current_user.requested_reviews
        @acc_reviews = current_user.accepted_reviews
        @req_reviews = Review.where.not(accepted: true, reviewee_id: current_user.id)
    end

    def new 
        @review = Review.new
    end

    def create
        @review = current_user.requested_reviews.build()
        @project = Project.find_by(title: params[:review][:project])
        @review.project = @project
        @review.save
        redirect_to reviews_path
    end

    def update
        if params[:accepted] == "true"
            @review = Review.find(params[:id])
            @review.reviewer = current_user
            @review.accepted = true
            @review.save
        elsif params[:accepted] == "false"
            @review = Review.find(params[:id])
            @review.reviewer = nil
            @review.accepted = false
            @review.save
        end
        redirect_to reviews_path
    end 

    private 

    def review_params
        params.require(:review).permit()
    end 

end
