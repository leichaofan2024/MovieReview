class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
  end
  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end
  def new
    @movie = Movie.new
  end
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to movies_path, notice: "成功新建影片！"
    else
      render :new
    end
  end
  def edit
    @movie = Movie.find(params[:id])
  end
  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "更新成功!"
    else
      render :edit
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "你已成功删除影片!"
  end
  def join_to_favorite
    @movie = Movie.find(params[:id])
    current_user.join!(@movie)
    redirect_to movie_path(@movie)
    flash[:notice] = "已经加入收藏！"
  end
  def quite_favorite
    @movie = Movie.find(params[:id])
    current_user.quite!(@movie)
    redirect_to movie_path(@movie)
    flash[:alert] = "已退出收藏！"
  end
  private

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
