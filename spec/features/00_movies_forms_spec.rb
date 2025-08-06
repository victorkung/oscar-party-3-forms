require "rails_helper"

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a form for creating movies", :points => 1 do
    visit "/backdoor"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a label for 'Title' with text: 'Title'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("label", text: "Title")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a label for 'Year' with text: 'Year'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("label", text: "Year")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a label for 'Duration' with text: 'Duration'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("label", text: "Duration")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a button with text 'Create Movie'", :points => 1, hint: h("copy_must_match") do
    visit "/backdoor"

    expect(page).to have_css("button", text: "Create Movie")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "creates a Movie when 'Create Movie' form is submitted", :points => 5, hint: h("button_type") do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    initial_number_of_movies = Movie.count
    test_title = "Test Movie"
    test_year = 2023
    test_duration = 120

    visit "/backdoor"

    fill_in "Title", with: test_title
    fill_in "Year", with: test_year
    select "#{director.first_name} #{director.last_name}", from: "Director"

    click_on "Create Movie"

    final_number_of_movies = Movie.count
    expect(final_number_of_movies).to eq(initial_number_of_movies + 1)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "saves the title and year when 'Create Movie' form is submitted", :points => 2, hint: h("label_for_input") do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    initial_number_of_movies = Movie.count
    test_title = "Test Movie"
    test_year = 2023
    test_duration = 120

    visit "/backdoor"

    fill_in "Title", with: test_title
    fill_in "Year", with: test_year
    select "#{director.first_name} #{director.last_name}", from: "Director"

    click_on "Create Movie"

    last_movie = Movie.order(created_at: :asc).last
    expect(last_movie.title).to eq(test_title)
    expect(last_movie.year).to eq(test_year)
  end
end

describe "/backdoor/movies" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "lists all movies", :points => 1 do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    movie = Movie.new
    movie.title = "Test Movie"
    movie.year = 2023
    movie.duration = 120
    movie.director_id = director.id
    movie.save

    visit "/backdoor/movies"

    expect(page).to have_content(movie.title)
  end
end

describe "/backdoor/movies/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "displays an edit form for the movie", :points => 1 do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    movie = Movie.new
    movie.title = "Test Movie"
    movie.year = 2023
    movie.duration = 120
    movie.director_id = director.id
    movie.save

    visit "/backdoor/movies/#{movie.id}"

    expect(page).to have_css("form")
    expect(page).to have_field("Title", with: movie.title)
    expect(page).to have_field("Year", with: movie.year)
  end
end

describe "/backdoor/movies/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "updates the movie when form is submitted", :points => 1 do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    movie = Movie.new
    movie.title = "Test Movie"
    movie.year = 2023
    movie.duration = 120
    movie.director_id = director.id
    movie.save

    visit "/backdoor/movies/#{movie.id}"

    fill_in "Title", with: "Updated Movie"
    fill_in "Year", with: 2024

    click_on "Update Movie"

    movie.reload
    expect(movie.title).to eq("Updated Movie")
    expect(movie.year).to eq(2024)
  end
end

describe "/backdoor/delete_movie/[MOVIE ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "removes a record from the Movie table", :points => 1 do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    movie = Movie.new
    movie.title = "Test Movie"
    movie.year = 2023
    movie.duration = 120
    movie.director_id = director.id
    movie.save

    visit "/backdoor/delete_movie/#{movie.id}"

    expect(Movie.exists?(movie.id)).to be(false)
  end
end

describe "/backdoor/delete_movie/[MOVIE ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "redirects to /backdoor/movies", :points => 1, hint: h("redirect_vs_render") do
    director = Director.new
    director.first_name = "Test"
    director.last_name = "Director"
    director.save

    movie = Movie.new
    movie.title = "Test Movie"
    movie.year = 2023
    movie.duration = 120
    movie.director_id = director.id
    movie.save

    visit "/backdoor/delete_movie/#{movie.id}"

    expect(page).to have_current_path("/backdoor/movies")
  end
end
