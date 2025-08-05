task(:scrape) do
  require "json"
  require "http"
  require "date"

  # Setup TMDB
  api_key = ENV.fetch("TMDB_KEY")
  base_url = "https://api.themoviedb.org/3"

  # Read Oscar nominees JSON
  oscar_data = JSON.parse(File.read(Rails.root.join("lib/tasks/scraped_oscar_nominees.json")))
  output_file = Rails.root.join("lib/tasks/sample_data.json")

  # Initialize arrays to store details
  movie_details = []
  director_details = []
  actor_details = []
  credit_details = []

  # ID counters for sequential primary keys
  credit_id_counter = 0
  movie_id_counter = 0
  director_id_counter = 0
  actor_id_counter = 0

  # Mapping from TMDB IDs to our sequential IDs
  director_id_map = {}
  actor_id_map = {}

  # Process each year's nominations
  oscar_data.each do |year_data|
    # Extract the year from the string like "2015 (88th)"
    year_match = year_data["year"].match(/(\d{4})/)
    next unless year_match
    oscar_year = year_match[1].to_i

    # Extract the Oscar ceremony number from the string like "2015 (88th)"
    cohort_match = year_data["year"].match(/\((\d+)/)
    oscar_cohort = cohort_match ? cohort_match[1].to_i : nil

    # Process each movie from this year
    year_data["nominations"].each do |nomination|
      movie_title = nomination["film"]
      movie_winner = nomination["winner"]
      movie_id_counter += 1

      # Search for movie in TMDB
      search_response = HTTP.get("#{base_url}/search/movie", params: {
        api_key: api_key,
        query: movie_title
      })
      search_data = JSON.parse(search_response.body.to_s)

      next if search_data["results"].nil? || search_data["results"].empty?

      # Find the movie that matches this specific Oscar year
      correct_movie = search_data["results"].find do |result|
        next if result["release_date"].nil? || result["release_date"].empty?
        release_year = Date.parse(result["release_date"]).year
        release_year == oscar_year
      end

      # If no exact year match, try year before (for late releases)
      if correct_movie.nil?
        correct_movie = search_data["results"].find do |result|
          next if result["release_date"].nil? || result["release_date"].empty?
          release_year = Date.parse(result["release_date"]).year
          release_year == (oscar_year - 1)
        end
      end

      next if correct_movie.nil?

      # Get full movie details
      movie_response = HTTP.get("#{base_url}/movie/#{correct_movie["id"]}", params: {
        api_key: api_key
      })
      movie = JSON.parse(movie_response.body.to_s)

      # Get credits (cast and crew)
      credits_response = HTTP.get("#{base_url}/movie/#{correct_movie["id"]}/credits", params: {
        api_key: api_key
      })
      credits = JSON.parse(credits_response.body.to_s)

      # Movie details
      movie_record = {
        id: movie_id_counter,
        description: movie["overview"],
        duration: movie["runtime"],
        image: movie["poster_path"] ? "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}" : nil,
        title: movie["title"],
        year: Date.parse(movie["release_date"]).year,
        released_on: movie["release_date"],
        oscar_cohort: oscar_cohort,
        result: movie_winner ? "won" : "did not win",
        created_at: "2024-03-14 12:00:00",
        updated_at: "2024-03-14 12:00:00",
        director_id: nil # Will update after getting director
      }
      movie_details.push(movie_record)

      # Get director from crew
      director = credits["crew"]&.find { |member| member["job"] == "Director" }
      if director
        # Check if we've already seen this director
        if director_id_map[director["id"]].nil?
          director_id_counter += 1
          director_id_map[director["id"]] = director_id_counter

          # Get full person details
          person_response = HTTP.get("#{base_url}/person/#{director["id"]}", params: {
            api_key: api_key
          })
          director_obj = JSON.parse(person_response.body.to_s)

          director_details.push({
            id: director_id_counter,
            bio: director_obj["biography"],
            dob: director_obj["birthday"],
            image: director_obj["profile_path"] ?
              "https://image.tmdb.org/t/p/w500#{director_obj["profile_path"]}" :
              "https://robohash.org/#{director_obj["name"]}?set=set3",
            first_name: director_obj["name"].split.first,
            last_name: director_obj["name"].split.drop(1).join(" "),
            created_at: "2024-03-14 12:00:00",
            updated_at: "2024-03-14 12:00:00"
          })
        end

        # Update movie's director_id with our sequential ID
        movie_record[:director_id] = director_id_map[director["id"]]
      end

      # Get cast/characters (limit to first 10 cast members)
      cast = credits["cast"]&.first(10) || []
      cast.each do |member|
        credit_id_counter += 1  # Increment before each use

        # Check if we've already seen this actor
        if actor_id_map[member["id"]].nil?
          actor_id_counter += 1
          actor_id_map[member["id"]] = actor_id_counter

          # Get full person details
          person_response = HTTP.get("#{base_url}/person/#{member["id"]}", params: {
            api_key: api_key
          })
          actor_obj = JSON.parse(person_response.body.to_s)

          # Add actor details with sequential ID
          actor_details.push({
            id: actor_id_counter,
            bio: actor_obj["biography"],
            dob: actor_obj["birthday"],
            image: actor_obj["profile_path"] ?
              "https://image.tmdb.org/t/p/w500#{actor_obj["profile_path"]}" :
              "https://robohash.org/#{actor_obj["name"]}?set=set3",
            first_name: actor_obj["name"].split.first,
            last_name: actor_obj["name"].split.drop(1).join(" "),
            created_at: "2024-03-14 12:00:00",
            updated_at: "2024-03-14 12:00:00"
          })
        end

        # Add credit details with globally unique ID and mapped actor ID
        credit_details.push({
          id: credit_id_counter,
          role: member["character"],
          created_at: "2024-03-14 12:00:00",
          updated_at: "2024-03-14 12:00:00",
          actor_id: actor_id_map[member["id"]],
          movie_id: movie_id_counter
        })
      end
    end
  end

  # No need to remove duplicates anymore since we're using mapping

  # Write to JSON file
  output = {
    movies: movie_details,
    directors: director_details,
    actors: actor_details,
    credits: credit_details
  }

  File.write(output_file, JSON.pretty_generate(output))

  puts "Scraping complete! Created:"
  puts "  #{movie_details.count} movies"
  puts "  #{director_details.count} directors"
  puts "  #{actor_details.count} actors"
  puts "  #{credit_details.count} credits"
end
