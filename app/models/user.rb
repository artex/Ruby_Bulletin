class User < ApplicationRecord
    has_many :create_user_posts, class_name: 'Post', foreign_key: 'create_user_id'
    has_many :update_user_posts, class_name: 'Post', foreign_key: 'update_user_id'
    has_secure_password
    validates :phone, presence: true,:numericality => true, :length => { :minimum => 6, :maximum => 13 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
