class Category < ApplicationRecord
  validates :name, presence: true
  has_many :posts,  -> {order "created_at DESC"}, dependent: :destroy
  
end
