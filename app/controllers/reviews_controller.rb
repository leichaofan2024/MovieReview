class ReviewsController < ApplicationController
  before_action :require_favorite
  # def new
  #   @movie = Movie.find(params[:movie_id])
  #   @review = Review.new
  # end
  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: "评论成功！"
    else
      render :new
    end
  end
  def require_favorite
    @movie = Movie.find(params[:movie_id])
    if !current_user.favorites.include?(@movie)
      redirect_to movie_path(@movie), alert: "你要先加入收藏才能评论哦～～"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
