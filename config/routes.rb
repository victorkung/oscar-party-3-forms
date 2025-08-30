Rails.application.routes.draw do
  get("/", { :controller => "misc", :action => "homepage" })
  get("/about", { :controller => "misc", :action => "about" })

  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest", { :controller => "directors", :action => "min_dob" })

  get("/directors", { :controller => "directors", :action => "index" })
  get("/directors/:path_id", { :controller => "directors", :action => "show" })

  get("/movies", { :controller => "movies", :action => "index" })
  get("/movies/:path_id", { :controller => "movies", :action => "show" })

  get("/actors", { :controller => "actors", :action => "index" })
  get("/actors/:path_id", { :controller => "actors", :action => "show" })

  get("/backdoor", { :controller => "backdoor", :action => "backdoor_index" })

  get("/backdoor/directors", { :controller => "backdoor", :action => "directors_index" })
  get("/backdoor/directors/:path_id", { :controller => "backdoor", :action => "director_show" })
  post("/backdoor/insert_director", { :controller => "backdoor", :action => "create_director" })
  post("/backdoor/modify_director/:path_id", { :controller => "backdoor", :action => "update_director" })
  get("/backdoor/delete_director/:path_id", { :controller => "backdoor", :action => "destroy_director" })

  get("/backdoor/actors", { :controller => "backdoor", :action => "actors_index" })
  get("/backdoor/actors/:path_id", { :controller => "backdoor", :action => "actor_show" })
  post("/backdoor/insert_actor", { :controller => "backdoor", :action => "create_actor" })
  post("/backdoor/modify_actor/:path_id", { :controller => "backdoor", :action => "update_actor" })
  get("/backdoor/delete_actor/:path_id", { :controller => "backdoor", :action => "destroy_actor" })

  get("/backdoor/movies", { :controller => "backdoor", :action => "movies_index" })
  get("/backdoor/movies/:path_id", { :controller => "backdoor", :action => "movie_show" })
  post("/backdoor/insert_movie", { :controller => "backdoor", :action => "create_movie" })
  post("/backdoor/modify_movie/:path_id", { :controller => "backdoor", :action => "update_movie" })
  get("/backdoor/delete_movie/:path_id", { :controller => "backdoor", :action => "destroy_movie" })

end
