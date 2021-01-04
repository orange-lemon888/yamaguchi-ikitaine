class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :favorites                                    #行きたいねをしている投稿への参照
  has_many :ikitais, through: :favorites, source: :post  #行きたいねをしている投稿(複数）favoritesテーブルのpost_id参照
  
  def ikitaine(mark_post)
    self.favorites.find_or_create_by(post_id: mark_post.id)
  end
  
  def unikitaine(mark_post)
    favorite = self.favorites.find_by(post_id: mark_post.id)
    favorite.destroy if favorite
  end
  
  def ikitai?(mark_post)
    self.ikitais.include?(mark_post)
  end
end
