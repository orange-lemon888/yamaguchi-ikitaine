class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [ :new, :edit, :create, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  # GET /posts
  # GET /posts.json
  def index
    @user = current_user
    @categories = [
      [0, "見る／遊ぶ"],
      [1, "食べる"],
      [2, "泊まる"]
    ]
    @posts = Post.order(id: :desc).page(params[:page]).per(10)
    #@plays = Post.where(category: "0")   #見る／遊ぶ
    #@posts = Post.where(category: "0")   #見る／遊ぶ
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by(id: params[:id])
      
  end

  # GET /posts/new
  def new
    @post = Post.new
    @toukou = '新規投稿'
  end

  # GET /posts/1/edit
  def edit
    @toukou = '投稿記事編集'
  end

  # POST /posts
  # POST /posts.json
  def create
    if logged_in?
      @post = current_user.posts.build(post_params) # form_with用
      @posts = current_user.posts.order(id: :desc).page(params[:page]).per(10)
    
      #@post = Post.new(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #def eat   #食べる投稿一覧
    #@user = current_user
    #@eats = Post.where(category: "1")
    #@posts = Post.where(category: "1") 
  #end
  
  #def stay  #泊まる投稿一覧
    #@user = current_user
    #@stays = Post.where(category: "2")
    #@posts = Post.where(category: "2") 
  #end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:category, :title, :subtitle, :area, :content, :image, :user_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
