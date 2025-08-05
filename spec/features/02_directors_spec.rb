require "rails_helper"

describe "/directors/youngest" do
  it "displays only the youngest directors name", :points => 1 do
    first_director = Director.new
    first_director.first_name = "John"
    first_director.last_name = "Smith"
    first_director.dob = 42.years.ago
    first_director.save

    second_director = Director.new
    second_director.first_name = "Conan"
    second_director.last_name = "O'Brien"
    second_director.dob = 101.years.ago
    second_director.save

    third_director = Director.new
    third_director.first_name = "Cathy"
    third_director.last_name = "Yan"
    third_director.dob = 36.years.ago
    third_director.save

    fourth_director = Director.new
    fourth_director.first_name = "Wes"
    fourth_director.last_name = "Anderson"
    fourth_director.dob = nil
    fourth_director.save

    visit "/directors/youngest"

    expect(page).to have_content(third_director.last_name),
      "Expected page to display #{third_director.last_name}, but didn't."

    expect(page).not_to have_content(first_director.last_name),
      "Expected page to NOT display #{first_director.last_name}, but did."
    expect(page).not_to have_content(second_director.last_name),
      "Expected page to NOT display #{second_director.last_name}, but did."
    expect(page).not_to have_content(fourth_director.last_name),
      "Expected page to NOT display #{fourth_director.last_name}, but did."
  end
end

describe "/directors/eldest" do
  it "displays only the eldest directors name", :points => 1 do
    first_director = Director.new
    first_director.first_name = "John"
    first_director.last_name = "Smith"
    first_director.dob = 42.years.ago
    first_director.save

    second_director = Director.new
    second_director.first_name = "Conan"
    second_director.last_name = "O'Brien"
    second_director.dob = 101.years.ago
    second_director.save

    third_director = Director.new
    third_director.first_name = "Cathy"
    third_director.last_name = "Yan"
    third_director.dob = 36.years.ago
    third_director.save

    fourth_director = Director.new
    fourth_director.first_name = "Wes"
    fourth_director.last_name = "Anderson"
    fourth_director.dob = nil
    fourth_director.save

    visit "/directors/eldest"

    expect(page).to have_content(second_director.last_name),
      "Expected page to display #{second_director.last_name}, but didn't."

    expect(page).not_to have_content(first_director.last_name),
      "Expected page to NOT display #{first_director.last_name}, but did."
    expect(page).not_to have_content(third_director.last_name),
      "Expected page to NOT display #{third_director.last_name}, but did."
    expect(page).not_to have_content(fourth_director.last_name),
      "Expected page to NOT display #{fourth_director.last_name}, but did."
  end
end

describe "/directors" do
  it "lists the names of each Director record in the database", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.first_name = "Trina"
    other_director.last_name = "Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    iris_roy = Director.new
    iris_roy.first_name = "Iris"
    iris_roy.last_name = "Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors"

    expect(page).to have_text(director.last_name),
      "Expected page to have the name, '#{director.last_name}'"

    expect(page).to have_text(other_director.last_name),
      "Expected page to have the name, '#{other_director.last_name}'"

    expect(page).to have_text(iris_roy.last_name),
      "Expected page to have the name, '#{iris_roy.last_name}'"
  end
end

describe "/directors" do
  it "has a clickable name link to the details page of each director", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.first_name = "Trina"
    other_director.last_name = "Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    iris_roy = Director.new
    iris_roy.first_name = "Iris"
    iris_roy.last_name = "Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors"

    expect(page).to have_tag("a", :with => { :href => "/directors/#{director.id}" }, :text => /#{director.last_name}/i),
      "Expected page to have the a link with the text '#{director.last_name}' and an href of '/directors/#{director.id}'"

    expect(page).to have_tag("a", :with => { :href => "/directors/#{other_director.id}" }, :text => /#{other_director.last_name}/i),
      "Expected page to have the a link with the text '#{other_director.last_name}' and an href of '/directors/#{other_director.id}'"

    expect(page).to have_tag("a", :with => { :href => "/directors/#{iris_roy.id}" }, :text => /#{iris_roy.last_name}/i),
      "Expected page to have the a link with the text '#{iris_roy.last_name}' and an href of '/directors/#{iris_roy.id}'"
  end
end


describe "/directors/[DIRECTOR ID]" do
  it "displays the name of a specified Director record", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    iris_roy = Director.new
    iris_roy.first_name = "Iris"
    iris_roy.last_name = "Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.last_name),
      "Expected page to have the name, '#{director.last_name}'"

    expect(page).to_not have_text(iris_roy.last_name),
      "Expected page to NOT have the name, '#{iris_roy.last_name}', but found it anyway."
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the dob of a specified Director record", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = ""
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.dob),
      "Expected page to have the dob, '#{director.dob}'"
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the bio of a specified Director record", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = ""
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.bio),
      "Expected page to have the bio, '#{director.bio}'"
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the names of the movies that were directed by the Director", points: 1 do
    director = Director.new
    director.first_name = "Travis"
    director.last_name = "McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = "https://robohash.org/Random%20Image?set=set4"
    director.save

    other_director = Director.new
    other_director.first_name = "Trina"
    other_director.last_name = "Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    the_turgle = Movie.new
    the_turgle.title = "The Turgle"
    the_turgle.description = "Matt Damon, being Matt Damon."
    the_turgle.year = 2008
    the_turgle.duration = 90
    the_turgle.director_id = director.id
    the_turgle.save

    hello_world = Movie.new
    hello_world.title = "Hello, World"
    hello_world.description = "Program's first world."
    hello_world.year = 2001
    hello_world.duration = 95
    hello_world.director_id = other_director.id
    hello_world.save

    deep_impact = Movie.new
    deep_impact.title = "Deep Impact"
    deep_impact.description = "It's like evangelion."
    deep_impact.year = 1999
    deep_impact.duration = 95
    deep_impact.director_id = director.id
    deep_impact.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(the_turgle.title),
      "Expected page to have the title, '#{the_turgle.title}'"
    expect(page).to have_text(deep_impact.title),
      "Expected page to have the title, '#{deep_impact.title}'"
    expect(page).to_not have_text(hello_world.title),
      "Expected page to not have the title, '#{hello_world.title}'"
  end
end


describe "/directors/[DIRECTOR ID]" do
  it "has links to the details page of each Movie in the Director's filmography", points: 1 do
    director = Director.new
    director.first_name = "Matthew"
    director.last_name = "Mercer"
    director.dob = 36.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.first_name = "Trina"
    other_director.last_name = "Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    the_turgle = Movie.new
    the_turgle.title = "The Turgle"
    the_turgle.description = "Matt Damon, being Matt Damon."
    the_turgle.year = 2008
    the_turgle.duration = 90
    the_turgle.director_id = director.id
    the_turgle.save

    hello_world = Movie.new
    hello_world.title = "Hello, World"
    hello_world.description = "Program's first world."
    hello_world.year = 2001
    hello_world.duration = 95
    hello_world.director_id = other_director.id
    hello_world.save

    deep_impact = Movie.new
    deep_impact.title = "Deep Impact"
    deep_impact.description = "It's like evangelion."
    deep_impact.year = 1999
    deep_impact.duration = 95
    deep_impact.director_id = director.id
    deep_impact.save

    visit "/directors/#{director.id}"

    expect(page).to have_link(the_turgle.title, href: "/movies/#{the_turgle.id}"),
      "Expected page to have a link to '/movies/#{the_turgle.id}' with text '#{the_turgle.title}'"

    expect(page).to have_link(deep_impact.title, href: "/movies/#{deep_impact.id}"),
      "Expected page to have a link to '/movies/#{deep_impact.id}' with text '#{deep_impact.title}'"

    expect(page).to_not have_link(hello_world.title, href: "/movies/#{hello_world.id}"),
      "Expected page to NOT have a link to '/movies/#{hello_world.id}' with text '#{hello_world.title}'"
  end
end
