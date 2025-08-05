class DirectorsController < ApplicationController
  def index
    @list_of_directors = Director.order(Director.arel_table[:dob].desc.nulls_last)

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })

    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    @youngest = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc }).
      at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    @eldest = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc }).
      at(0)

    render({ :template => "director_templates/eldest" })
  end
end
