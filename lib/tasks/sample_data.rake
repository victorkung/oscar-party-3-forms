desc "Hydrate the database with sample data from JSON"
task({ :sample_data => :environment }) do
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  # Read and parse the JSON file
  json_data = JSON.parse(File.read(Rails.root.join("lib/tasks/sample_data.json")))

  # Clear existing records
  Director.delete_all
  Movie.delete_all
  Actor.delete_all
  Credit.delete_all

  # Insert all records from JSON
  Director.insert_all!(json_data["directors"])
  puts "Created #{Director.count} directors"

  Movie.insert_all!(json_data["movies"])
  puts "Created #{Movie.count} movies"

  Actor.insert_all!(json_data["actors"])
  puts "Created #{Actor.count} actors"

  Credit.insert_all!(json_data["credits"])
  puts "Created #{Credit.count} credits"

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
end
