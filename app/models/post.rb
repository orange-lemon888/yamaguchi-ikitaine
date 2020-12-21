class Post < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, GimageUploader
  
  validates :content, presence: true, length: { maximum: 255 }
end
