class Post < ApplicationRecord
    belongs_to :create_user, class_name: 'User'
    belongs_to :update_user, class_name: 'User'
end
