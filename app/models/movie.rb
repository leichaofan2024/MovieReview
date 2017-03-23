class Movie < ApplicationRecord
  has_many :reviews
  belongs_to :user
  has_many :favorite_movies
  has_many :fans, through: :favorite_movies, source: :user


end
