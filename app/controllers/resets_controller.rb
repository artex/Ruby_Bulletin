class ResetsController < ApplicationController
    before_action :authorized, only: [:auto_login]
    def create
        # @reset = Reset.new(reset_params)
        @reset = PasswordReset.new(reset_params)
        @reset.save
    end

    def update
        @reset = PasswordReset.find_by(token: params[:token])
        render json: @reset
    end

    private
    def reset_params
        params[:reset].permit(:email, :token)
    end
end
