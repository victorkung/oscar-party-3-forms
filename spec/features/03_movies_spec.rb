require "rails_helper"

describe "/movies" do
  it "lists the titles of each Movie record in the database", points: 1 do
    first_director = Director.new
    first_director.first_name = "Greta"
    first_director.last_name = "Gerwig"
    first_director.save

    second_director = Director.new
    second_director.first_name = "Christopher"
    second_director.last_name = "Nolan"
    second_director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = first_director.id
    movie.save

    other_movie = Movie.new
    other_movie.title = "Oppenheimer"
    other_movie.year = 2023
    other_movie.duration = 180
    other_movie.description = "The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb."
    other_movie.image = "https://example.com/oppenheimer.jpg"
    other_movie.director_id = second_director.id
    other_movie.save

    third_movie = Movie.new
    third_movie.title = "Little Women"
    third_movie.year = 2019
    third_movie.duration = 135
    third_movie.description = "Jo March reflects back and forth on her life, telling the beloved story of the March sisters."
    third_movie.image = "https://example.com/littlewomen.jpg"
    third_movie.director_id = first_director.id
    third_movie.save

    visit "/movies"

    expect(page).to have_text(movie.title),
      "Expected page to have the title, '#{movie.title}'"

    expect(page).to have_text(other_movie.title),
      "Expected page to have the title, '#{other_movie.title}'"

    expect(page).to have_text(third_movie.title),
      "Expected page to have the title, '#{third_movie.title}'"
  end
end

describe "/movies" do
  it "has a clickable name link to the details page of each movie", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    other_movie = Movie.new
    other_movie.title = "Little Women"
    other_movie.year = 2019
    other_movie.duration = 135
    other_movie.description = "Jo March reflects back and forth on her life, telling the beloved story of the March sisters."
    other_movie.image = "https://example.com/littlewomen.jpg"
    other_movie.director_id = director.id
    other_movie.save

    visit "/movies"

    expect(page).to have_tag("a", :with => { :href => "/movies/#{movie.id}" }, :text => /#{movie.title}/i),
      "Expected page to have the a link with the text '#{movie.title}' and an href of '/movies/#{movie.id}'"

    expect(page).to have_tag("a", :with => { :href => "/movies/#{other_movie.id}" }, :text => /#{other_movie.title}/i),
      "Expected page to have the a link with the text '#{other_movie.title}' and an href of '/movies/#{other_movie.id}'"
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the title of a specified Movie record", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    other_movie = Movie.new
    other_movie.title = "Little Women"
    other_movie.year = 2019
    other_movie.duration = 135
    other_movie.description = "Jo March reflects back and forth on her life, telling the beloved story of the March sisters."
    other_movie.image = "https://example.com/littlewomen.jpg"
    other_movie.director_id = director.id
    other_movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_text(movie.title),
      "Expected page to have the title, '#{movie.title}'"

    expect(page).to_not have_text(other_movie.title),
      "Expected page to NOT have the title, '#{other_movie.title}', but found it anyway."
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the year of a specified Movie record", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_text(movie.year),
      "Expected page to have the year, '#{movie.year}'"
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the duration of a specified Movie record", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_text(movie.duration),
      "Expected page to have the duration, '#{movie.duration}'"
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the description of a specified Movie record", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_text(movie.description),
      "Expected page to have the description, '#{movie.description}'"
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the name of the Director who directed the Movie", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    other_director = Director.new
    other_director.first_name = "Christopher"
    other_director.last_name = "Nolan"
    other_director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_text(director.last_name),
      "Expected page to have the director's name, '#{director.last_name}'"

    expect(page).to_not have_text(other_director.last_name),
      "Expected page to NOT have the director's name, '#{other_director.last_name}'"
  end
end

describe "/movies/[MOVIE ID]" do
  it "has a link to the details page of the Director", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    movie = Movie.new
    movie.title = "Barbie"
    movie.year = 2023
    movie.duration = 114
    movie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    movie.image = "https://example.com/barbie.jpg"
    movie.director_id = director.id
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_link("#{director.first_name} #{director.last_name}", href: "/directors/#{director.id}"),
      "Expected page to have a link to '/directors/#{director.id}' with text '#{director.first_name} #{director.last_name}'"
  end
end
