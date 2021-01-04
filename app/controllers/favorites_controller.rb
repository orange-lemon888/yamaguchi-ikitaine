class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @ikitai_posts = current_user.favorites
  end
  
  def create
    #行きたいねすべき投稿のpost_idをparams[:post_id]として取得する
    post = Post.find(params[:post_id])
    current_user.ikitaine(post)
    flash[:success] = '行きたいねに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unikitaine(post)
    flash[:success] = '行きたいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
