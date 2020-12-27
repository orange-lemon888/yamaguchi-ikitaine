class ApplicationController < ActionController::Base
  
  include SessionsHelper
    
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    #category  0:見る/遊ぶ, 1:食べる, 2:泊まる
    @count_posts = user.posts.count
  end
end
