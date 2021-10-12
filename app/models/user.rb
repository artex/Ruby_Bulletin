class User < ApplicationRecord
    has_secure_password
    validates :phone, presence: true,:numericality => true, :length => { :minimum => 6, :maximum => 13 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
