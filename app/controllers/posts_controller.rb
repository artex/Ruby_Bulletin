class PostsController < ApplicationController
    before_action :authorized, except: [:list]
    def list
        @posts = []
        @post = Post.all
        @post.each do |post|
            @aa = post.create_user
            @bb = post.update_user
            user_info = post.attributes
            user_info[:create_user] = @aa.name
            user_info[:update_user] = @bb.name
            user_info[:created_date] = post.created_at.strftime("%Y/%m/%d")
            @posts << user_info
        end
        render json: @posts
    end 
end
