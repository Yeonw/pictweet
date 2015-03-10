class TweetsController < ApplicationController
  before_action :redirect_to_index, only: [:new, :create]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
  end

  def create
    Tweet.create(create_params)
  end

  def destroy
    tweet= Tweet.find(id_params[:id])
    if tweet.user_id == current_user.id
      tweet.delete
    end
  end
  def edit
    @tweet = Tweet.find(id_params[:id])
  end
  def update
    tweet = Tweet.find(id_params[:id])
    if tweet.user_id == current_user.id
      tweet.update(image: create_params[:image], text: create_params[:text])
    end
  end

  def redirect_to_index
    redirect_to :action => "index" unless user_signed_in?
  end


  private
  def create_params
    params.permit(:image, :text).merge(user_id: current_user.id)
  end
  def id_params
    params.permit(:id)
  end
end
