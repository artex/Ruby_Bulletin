class PostsController < ApplicationController
    before_action :authorized, except: [:list]
    def list
        @posts = []
        @post = Post.where(deleted_at: [nil, ""])
        @post.each do |post|
            @aa = post.create_user
            @bb = post.update_user
            user_info = post.attributes
            user_info[:create_user] = @aa.name
            user_info[:update_user] = @bb.name
            user_info[:created_date] = post.created_at.strftime("%Y/%m/%d")
            user_info[:updated_date] = post.updated_at.strftime("%Y/%m/%d")
            @posts << user_info
        end
        render json: @posts
    end 

    def confirm
        @post = Post.new(post_params)
      if !@post.valid?
        render json: @post.errors, status: 422
      else
        render json: @post
      end
    end

    def create
        @post = Post.new(post_params)
        @post.save
        render json: {noti: "Post Successfully created"}
    end

    def details
        @post = Post.find(params[:id])
        render json: @post
    end
    
    def edit
        @post = Post.find_by(id: params[:id])
        @post.title = params[:title]
        @post.description = params[:title]
        if !@post.valid?
            render json: @post.errors, status: 422
        else
            render json: {error: "no error"}        
        end
    end
    
    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        render json: {noti: "Post successfully edited"}
    end

    def delete
        @post = Post.find(params[:id])
        @post.update(post_params)
        render json: {data: "Post successfully deleted"}
    end

    private
  
    def post_params
      params.permit(:title, :description, :status, :create_user_id, :update_user_id, :deleted_user_id, :deleted_at)
    end
end
