class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews
  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie

  def join!(movie)
    favorites << movie
  end
  def quite!(movie)
    favorites.delete(movie)
  end 
end
