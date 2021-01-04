class Post < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, GimageUploader
  
  has_many :favorites,dependent: :destroy     #行きたいねをしているユーザへの参照
  has_many :users, through: :favorites        #行きたいねをしているユーザ(複数）favoritesのuser_id参照
  
  validates :content, presence: true, length: { maximum: 255 }
end
