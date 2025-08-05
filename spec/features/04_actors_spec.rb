require "rails_helper"

describe "/actors" do
  it "lists the names of each Actor record in the database", points: 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.image = ""
    actor.save

    other_actor = Actor.new
    other_actor.first_name = "Ryan"
    other_actor.last_name = "Gosling"
    other_actor.dob = 43.years.ago
    other_actor.image = ""
    other_actor.save

    third_actor = Actor.new
    third_actor.first_name = "America"
    third_actor.last_name = "Ferrera"
    third_actor.dob = 39.years.ago
    third_actor.image = ""
    third_actor.save

    visit "/actors"

    expect(page).to have_text(actor.last_name),
      "Expected page to have the name, '#{actor.last_name}'"

    expect(page).to have_text(other_actor.last_name),
      "Expected page to have the name, '#{other_actor.last_name}'"

    expect(page).to have_text(third_actor.last_name),
      "Expected page to have the name, '#{third_actor.last_name}'"
  end
end

describe "/actors" do
  it "has a clickable name link to the details page of each actor", points: 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.image = ""
    actor.save

    other_actor = Actor.new
    other_actor.first_name = "Ryan"
    other_actor.last_name = "Gosling"
    other_actor.dob = 43.years.ago
    other_actor.image = ""
    other_actor.save

    third_actor = Actor.new
    third_actor.first_name = "America"
    third_actor.last_name = "Ferrera"
    third_actor.dob = 39.years.ago
    third_actor.image = ""
    third_actor.save

    visit "/actors"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{actor.id}" }, :text => /#{actor.last_name}/i),
      "Expected page to have the a link with the text '#{actor.last_name}' and an href of '/actors/#{actor.id}'"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{other_actor.id}" }, :text => /#{other_actor.last_name}/i),
      "Expected page to have the a link with the text '#{other_actor.last_name}' and an href of '/actors/#{other_actor.id}'"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{third_actor.id}" }, :text => /#{third_actor.last_name}/i),
      "Expected page to have the a link with the text '#{third_actor.last_name}' and an href of '/actors/#{third_actor.id}'"
  end
end


describe "/actors/[ACTOR ID]" do
  it "displays the name of a specified Actor record", points: 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.image = ""
    actor.save

    other_actor = Actor.new
    other_actor.first_name = "Ryan"
    other_actor.last_name = "Gosling"
    other_actor.dob = 43.years.ago
    other_actor.image = ""
    other_actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_text(actor.last_name),
      "Expected page to have the name, '#{actor.last_name}'"

    expect(page).to_not have_text(other_actor.last_name),
      "Expected page to NOT have the name, '#{other_actor.last_name}', but found it anyway."
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays the dob of a specified Actor record", points: 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.bio = "Australian actress and producer"
    actor.image = ""
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_text(actor.dob),
      "Expected page to have the dob, '#{actor.dob}'"
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays the bio of a specified Actor record", points: 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.bio = "Australian actress and producer"
    actor.image = ""
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_text(actor.bio),
      "Expected page to have the bio, '#{actor.bio}'"
  end
end

describe "/actors/[ACTOR ID]" do
  it "displays the titles of the movies that the Actor appeared in", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.bio = "Australian actress and producer"
    actor.image = "https://robohash.org/Random%20Image?set=set4"
    actor.save

    other_actor = Actor.new
    other_actor.first_name = "Ryan"
    other_actor.last_name = "Gosling"
    other_actor.dob = 43.years.ago
    other_actor.image = ""
    other_actor.save

    barbie = Movie.new
    barbie.title = "Barbie"
    barbie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    barbie.year = 2023
    barbie.duration = 114
    barbie.director_id = director.id
    barbie.save

    little_women = Movie.new
    little_women.title = "Little Women"
    little_women.description = "Jo March reflects back and forth on her life, telling the beloved story of the March sisters."
    little_women.year = 2019
    little_women.duration = 135
    little_women.director_id = director.id
    little_women.save

    suicide_squad = Movie.new
    suicide_squad.title = "Suicide Squad"
    suicide_squad.description = "A secret government agency recruits imprisoned supervillains to execute dangerous black ops missions in exchange for clemency."
    suicide_squad.year = 2016
    suicide_squad.duration = 123
    suicide_squad.director_id = director.id
    suicide_squad.save

    # Create credits to link actors to movies
    credit1 = Credit.new
    credit1.actor_id = actor.id
    credit1.movie_id = barbie.id
    credit1.role = "Barbie"
    credit1.save

    credit2 = Credit.new
    credit2.actor_id = actor.id
    credit2.movie_id = suicide_squad.id
    credit2.role = "Harley Quinn"
    credit2.save

    credit3 = Credit.new
    credit3.actor_id = other_actor.id
    credit3.movie_id = barbie.id
    credit3.role = "Ken"
    credit3.save

    visit "/actors/#{actor.id}"

    expect(page).to have_text(barbie.title),
      "Expected page to have the title, '#{barbie.title}'"
    expect(page).to have_text(suicide_squad.title),
      "Expected page to have the title, '#{suicide_squad.title}'"
    expect(page).to_not have_text(little_women.title),
      "Expected page to not have the title, '#{little_women.title}'"
  end
end


describe "/actors/[ACTOR ID]" do
  it "has links to the details page of each Movie in the Actor's filmography", points: 1 do
    director = Director.new
    director.first_name = "Greta"
    director.last_name = "Gerwig"
    director.save

    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.dob = 33.years.ago
    actor.bio = "Australian actress and producer"
    actor.image = "https://robohash.org/Random%20Image?set=set4"
    actor.save

    other_actor = Actor.new
    other_actor.first_name = "Ryan"
    other_actor.last_name = "Gosling"
    other_actor.dob = 43.years.ago
    other_actor.image = ""
    other_actor.save

    barbie = Movie.new
    barbie.title = "Barbie"
    barbie.description = "Barbie suffers a crisis that leads her to question her world and her existence."
    barbie.year = 2023
    barbie.duration = 114
    barbie.director_id = director.id
    barbie.save

    little_women = Movie.new
    little_women.title = "Little Women"
    little_women.description = "Jo March reflects back and forth on her life, telling the beloved story of the March sisters."
    little_women.year = 2019
    little_women.duration = 135
    little_women.director_id = director.id
    little_women.save

    suicide_squad = Movie.new
    suicide_squad.title = "Suicide Squad"
    suicide_squad.description = "A secret government agency recruits imprisoned supervillains to execute dangerous black ops missions in exchange for clemency."
    suicide_squad.year = 2016
    suicide_squad.duration = 123
    suicide_squad.director_id = director.id
    suicide_squad.save

    # Create credits to link actors to movies
    credit1 = Credit.new
    credit1.actor_id = actor.id
    credit1.movie_id = barbie.id
    credit1.role = "Barbie"
    credit1.save

    credit2 = Credit.new
    credit2.actor_id = actor.id
    credit2.movie_id = suicide_squad.id
    credit2.role = "Harley Quinn"
    credit2.save

    credit3 = Credit.new
    credit3.actor_id = other_actor.id
    credit3.movie_id = barbie.id
    credit3.role = "Ken"
    credit3.save

    visit "/actors/#{actor.id}"

    expect(page).to have_link(barbie.title, href: "/movies/#{barbie.id}"),
      "Expected page to have a link to '/movies/#{barbie.id}' with text '#{barbie.title}'"

    expect(page).to have_link(suicide_squad.title, href: "/movies/#{suicide_squad.id}"),
      "Expected page to have a link to '/movies/#{suicide_squad.id}' with text '#{suicide_squad.title}'"

    expect(page).to_not have_link(little_women.title, href: "/movies/#{little_women.id}"),
      "Expected page to NOT have a link to '/movies/#{little_women.id}' with text '#{little_women.title}'"
  end
end
