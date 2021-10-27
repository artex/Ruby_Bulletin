class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
  
    def list 
      @users =[]
      @user = User.where(deleted_at: [nil, ""])

      @user.each do |user|
        @aa = User.find_by(id: user.create_user_id)
        @bb = User.find_by(id: user.update_user_id)
        user_info = user.attributes
        user_info[:user_name] = @aa.name
        user_info[:update_name] = @bb.name
        @users << user_info
      end
      render json: @users
    end

    def confirm
      @user = User.new(user_params)
      if !@user.valid?
        render json: @user.errors, status: 300
      else
        render json: @user
      end
    end
    def get
      @user = User.find(params[:id])
      @role = @user[:role]
      photoname = @user.profile
        path = "app/assets/images/"+photoname
        data = File.open(path, 'rb') {|file| file.read }
        photofile = "data:image;base64,#{Base64.encode64(data)}"
        render json: {"image": photofile,"role": @role }
    end
    def details
        @user = User.find(params[:id])
        photoname = @user.profile
        path = "app/assets/images/"+photoname
        data = File.open(path, 'rb') {|file| file.read }
        photofile = "data:image;base64,#{Base64.encode64(data)}"
        render json: {"image": photofile, "user": @user}
    end
    # REGISTER
    def create
      # @user = User.create(user_params)
      # if @user
      #   render json: {data: "User Successfully Created"}
      # end
      if params[:filename]
        name = params[:filename].original_filename
        path = File.join("app", "assets" , "images", name)
        File.open(path, "wb") { |f| f.write(params[:filename].read) }
        render json: {data: "User Successfully Created"}
      end
    @applicant = User.new(user_params)
    @applicant.save
    end
  
    def update
      if params[:filename]
        name = params[:filename].original_filename
        path = File.join("app", "assets" , "images", name)
        File.open(path, "wb") { |f| f.write(params[:filename].read) }
      end
      @user = User.find(params[:id])
      @user.update(user_params)
      render json: {data: "Profile Updated Successfully"}
    end

    def pwupdate
      @user = User.find_by(id: params[:id])
      if @user && @user.authenticate(params[:current])
      else
        render json: {error: "Current Password Wrong!"}, status: 401
      end
    end
    
    def pwupdated
      @user = User.find(params[:id])
      @user.update(user_params)
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token, noti: "Password is successfully updated"}
    end

    def delete
      @user = User.find(params[:id])
      @user.update(user_params)
      render json: {data: "User successfully deleted"}
    end

    def reset
      @email = User.find_by(email: params[:email])
      if (!User.exists?(email: params[:email]))
        render json: {error: "Email doesn't exist"}, status: 422
      else
          @token = @email.signed_id(purpose: "password_reset",expires_in: 15.minutes)
          # @reset = Reset.new(email: @email, token: @token)
          # @reset.save
          UserMailer.welcome_email(email: @email, token: @token).deliver_now
          render json: {data: "Email sent with password reset instructions.", token: @token, email: @email.email}
          
      end
    end

    def reset_pw
      @user = User.find_by(email: params[:email])
      if @user.update(password: params[:password])
      render json: {data: "Password has been reset"}
        else
          render json: {error: "this is error"}, status: 422
      end
    end
    
    # def reseted
    #   @user = User.new()
    # end

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