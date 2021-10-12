class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
  

    def confirm
      @user = User.new(user_params)
      if !@user.valid?
        render json: @user.errors, status: 300
        # render json: {error: "hello"}, status: 300

    else
        render json: @user
    end
    end
    # REGISTER
    def create
      @user = User.create(user_params)
      if @user.valid?
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
    # LOGGING IN
    def login
        @user = User.find_by(email: params[:email])
    
        if @user && @user.authenticate(params[:password])
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid email or password"}, status: 401
        end
      end
  
  
    def auto_login
      render json: @user
    end
  
    private
  
    def user_params
      params.permit(:name, :email, :password, :role, :phone, :dob, :address, :profile, :create_user_id, :update_user_id, :deleted_user_id, :deleted_at)


    end
  
  end