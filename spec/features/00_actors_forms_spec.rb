require "rails_helper"

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a form for creating actors", :points => 1 do
    visit "/backdoor"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a label for 'First Name' with text: 'First Name'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("label", text: "First Name")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a label for 'Last Name' with text: 'Last Name'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("label", text: "Last Name")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a button with text 'Create Actor'", :points => 1, hint: h("copy_must_match") do
    visit "/backdoor"

    expect(page).to have_css("button", text: "Create Actor")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "creates an Actor when 'Create Actor' form is submitted", :points => 5, hint: h("button_type") do
    initial_number_of_actors = Actor.count
    test_first_name = "Margot"
    test_last_name = "Robbie"

    visit "/backdoor"

    fill_in "Actor First Name", with: test_first_name
    fill_in "Actor Last Name", with: test_last_name

    click_on "Create Actor"

    final_number_of_actors = Actor.count
    expect(final_number_of_actors).to eq(initial_number_of_actors + 1)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "saves the first and last name when 'Create Actor' form is submitted", :points => 2, hint: h("label_for_input") do
    initial_number_of_actors = Actor.count
    test_first_name = "Margot"
    test_last_name = "Robbie"

    visit "/backdoor"

    fill_in "Actor First Name", with: test_first_name
    fill_in "Actor Last Name", with: test_last_name

    click_on "Create Actor"

    last_actor = Actor.order(created_at: :asc).last
    expect(last_actor.first_name).to eq(test_first_name)
    expect(last_actor.last_name).to eq(test_last_name)
  end
end

describe "/backdoor/actors" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "lists all actors", :points => 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.save

    visit "/backdoor/actors"

    expect(page).to have_content(actor.first_name)
    expect(page).to have_content(actor.last_name)
  end
end

describe "/backdoor/actors/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "displays an edit form for the actor", :points => 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.save

    visit "/backdoor/actors/#{actor.id}"

    expect(page).to have_css("form")
    expect(page).to have_field("First Name", with: actor.first_name)
    expect(page).to have_field("Last Name", with: actor.last_name)
  end
end

describe "/backdoor/actors/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "updates the actor when form is submitted", :points => 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.save

    visit "/backdoor/actors/#{actor.id}"

    fill_in "Actor First Name", with: "America"
    fill_in "Actor Last Name", with: "Ferrera"

    click_on "Update Actor"

    actor.reload
    expect(actor.first_name).to eq("America")
    expect(actor.last_name).to eq("Ferrera")
  end
end

describe "/backdoor/delete_actor/[ACTOR ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "removes a record from the Actor table", :points => 1 do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.save

    visit "/backdoor/delete_actor/#{actor.id}"

    expect(Actor.exists?(actor.id)).to be(false)
  end
end

describe "/backdoor/delete_actor/[ACTOR ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "redirects to /backdoor/actors", :points => 1, hint: h("redirect_vs_render") do
    actor = Actor.new
    actor.first_name = "Margot"
    actor.last_name = "Robbie"
    actor.save

    visit "/backdoor/delete_actor/#{actor.id}"

    expect(page).to have_current_path("/backdoor/actors")
  end
end
