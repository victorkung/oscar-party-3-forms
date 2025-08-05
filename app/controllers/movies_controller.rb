class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :year => :desc, :title => :asc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
