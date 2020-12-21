json.extract! post, :id, :category, :title, :subtitle, :area, :content, :image, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
