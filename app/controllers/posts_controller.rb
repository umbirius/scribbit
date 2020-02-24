class PostsController < ApplicationController
    def new 
        @post = Post.new
    end 

    def create
        @post = current_user.posts.build(post_params)
        if @post.save 
            redirect_to root_url
        else 
            render :new 
        end
    end 

    private

    def post_params
        params.require(:post).permit(:name, :description, :link)
    end
end
