class ActorsController < ApplicationController
  def index
    @list_of_actors = Actor.order(Actor.arel_table[:dob].desc.nulls_last)

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })

    @the_actor = matching_actors.at(0)

    render({ :template => "actor_templates/show" })
  end
end
