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

    def list_user
        @posts_user = []
        @post = Post.where(deleted_at: [nil, ""])
        @posts = @post.where(create_user_id: params[:id])
        @posts.each do |post|
            @aa = post.create_user
            @bb = post.update_user
            user_info = post.attributes
            user_info[:create_user] = @aa.name
            user_info[:update_user] = @bb.name
            user_info[:created_date] = post.created_at.strftime("%Y/%m/%d")
            user_info[:updated_date] = post.updated_at.strftime("%Y/%m/%d")
            @posts_user << user_info
        end
        render json: @posts_user
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

    def import
        user_id = params[:user_id]
        file = params[:file]
        if !File.extname(file).eql?(".csv")
            render json: {error: "Please Choose a csv format."}, status: 422
        else
            CSV.foreach(file.path, headers: true) do |row|
                if(row.count != 3)
                    break render json: {error: "Post upload csv must have 3 columns"}, status: 422
                else
                    if(row.headers[0] != "title" || row.headers[1] != "description" || row.headers[2] != "status")
                        break render json: {error: "column names should be match with database columns"}, status: 422
                    end
                    @post = Post.new
                    @post.attributes = row.to_hash.slice(*updatable_attributes)
                    @post.create_user_id = user_id
                    @post.update_user_id = user_id
                    if !@post.valid?
                        errors = @post.errors
                        break render json: {error1: @post.errors,error2: row[0]}, status: 422
                    else
                        @post.save
                    end
                    
                end             
            end
        end
    end

    def updatable_attributes
        ["title", "description", "status"]
    end

    def export
        @post = Post.all
        render json: @post
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
