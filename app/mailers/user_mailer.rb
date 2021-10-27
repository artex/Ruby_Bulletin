class UserMailer < ApplicationMailer
    default from: 'htetartex@gmail.com'
    def welcome_email(params)
        @token = params[:token]
        @email = params[:email]
        @url = "http://localhost:8080/"+@token+"/reset/"
        mail(to: @email.email,
             content_type: "text/html",
             subject: "Already rendered!")do |format|
             format.html
           end
        end
end
