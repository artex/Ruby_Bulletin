class Post < ApplicationRecord
    belongs_to :create_user, class_name: 'User'
    belongs_to :update_user, class_name: 'User'

    validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
    validates :description, presence: true

    # def self.import(file)
    #     CSV.foreach(file.path, headers: true) do |row|
    #         post = new
    #         post.attributes = row.to_hash.slice(*updatable_attributes)
    #         post.save
    #     end
    # end
    # def self.updatable_attributes
    #     ["title", "description", "status"]
    # end
end
