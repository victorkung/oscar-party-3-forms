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

end
