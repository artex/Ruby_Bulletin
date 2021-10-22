class Post < ApplicationRecord
    belongs_to :create_user, class_name: 'User'
    belongs_to :update_user, class_name: 'User'

    validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
    validates :description, presence: true
end
