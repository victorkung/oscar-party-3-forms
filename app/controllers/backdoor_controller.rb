class BackdoorController < ApplicationController

  http_basic_authenticate_with name: ENV.fetch("ADMIN_USERNAME"), password: ENV.fetch("ADMIN_PASSWORD")

  def backdoor_index
    render({ :template => "backdoor_templates/backdoor_index" })
  end

  def directors_index
    @list_of_directors = Director.all

    render({ :template => "backdoor_templates/directors_index" })
  end

  def director_show
    the_id = params.fetch("path_id")
    @the_director = Director.where({ :id => the_id }).at(0)

    render({ :template => "backdoor_templates/director_show" })
  end
  
  def create_director
    the_director = Director.new
    the_director.first_name = params.fetch("query_first_name")
    the_director.last_name = params.fetch("query_last_name")
    the_director.dob = params.fetch("query_dob")
    the_director.bio = params.fetch("query_bio")
    the_director.image = params.fetch("query_image")

    if the_director.valid?
      the_director.save
      redirect_to("/backdoor", { :notice => "Director created successfully." })
    else
      redirect_to("/backdoor", { :alert => the_director.errors.full_messages.to_sentence })
    end
  end

  def update_director
    the_id = params.fetch("path_id")
    the_director = Director.where({ :id => the_id }).at(0)

    the_director.first_name = params.fetch("query_first_name")
    the_director.last_name = params.fetch("query_last_name")
    the_director.dob = params.fetch("query_dob")
    the_director.bio = params.fetch("query_bio")
    the_director.image = params.fetch("query_image")

    if the_director.valid?
      the_director.save
      redirect_to("/backdoor/directors/#{the_director.id}", { :notice => "Director updated successfully." })
    else
      redirect_to("/backdoor/directors/#{the_director.id}", { :alert => the_director.errors.full_messages.to_sentence })
    end
  end

  def destroy_director
    the_id = params.fetch("path_id")
    the_director = Director.where({ :id => the_id }).at(0)

    the_director.destroy

    redirect_to("/backdoor/directors", { :notice => "Director deleted successfully." })
  end

end
