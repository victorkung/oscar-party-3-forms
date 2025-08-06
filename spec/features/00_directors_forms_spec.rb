require "rails_helper"

describe "/backdoor" do
  it "requires basic authentication", :points => 1 do
    visit "/backdoor"

    expect(page.status_code).to eq(401),
      "Expected /backdoor to require authentication but it didn't"
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a form for creating directors", :points => 1 do
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

  it "has at least two input elements", :points => 1, hint: h("label_for_input") do
    visit "/backdoor"

    expect(page).to have_css("input", minimum: 2)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "has a button with text 'Create Director'", :points => 1, hint: h("copy_must_match") do
    visit "/backdoor"

    expect(page).to have_css("button", text: "Create Director")
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "creates a Director when 'Create Director' form is submitted", :points => 5, hint: h("button_type") do
    initial_number_of_directors = Director.count
    test_first_name = "Joe"
    test_last_name = "Schmoe"

    visit "/backdoor"

    fill_in "Director First Name", with: test_first_name
    fill_in "Director Last Name", with: test_last_name

    click_on "Create Director"

    final_number_of_directors = Director.count
    expect(final_number_of_directors).to eq(initial_number_of_directors + 1)
  end
end

describe "/backdoor" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "saves the first and last name when 'Create Director' form is submitted", :points => 2, hint: h("label_for_input") do
    initial_number_of_directors = Director.count
    test_first_name = "Joe"
    test_last_name = "Schmoe"

    visit "/backdoor"

    fill_in "Director First Name", with: test_first_name
    fill_in "Director Last Name", with: test_last_name

    click_on "Create Director"

    last_director = Director.order(created_at: :asc).last
    expect(last_director.first_name).to eq(test_first_name)
    expect(last_director.last_name).to eq(test_last_name)
  end
end

describe "/backdoor/directors" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "lists all directors", :points => 1 do
    director = Director.new
    director.first_name = "Joe"
    director.last_name = "Schmoe"
    director.save

    visit "/backdoor/directors"

    expect(page).to have_content(director.first_name)
    expect(page).to have_content(director.last_name)
  end
end

describe "/backdoor/directors/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "displays an edit form for the director", :points => 1 do
    director = Director.new
    director.first_name = "Joe"
    director.last_name = "Schmoe"
    director.save

    visit "/backdoor/directors/#{director.id}"

    expect(page).to have_css("form")
    expect(page).to have_field("First Name", with: director.first_name)
    expect(page).to have_field("Last Name", with: director.last_name)
  end
end

describe "/backdoor/directors/[ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "updates the director when form is submitted", :points => 1 do
    director = Director.new
    director.first_name = "Joe"
    director.last_name = "Schmoe"
    director.save

    visit "/backdoor/directors/#{director.id}"

    fill_in "Director First Name", with: "Jane"
    fill_in "Director Last Name", with: "Doe"

    click_on "Update Director"

    director.reload
    expect(director.first_name).to eq("Jane")
    expect(director.last_name).to eq("Doe")
  end
end

describe "/backdoor/delete_director/[DIRECTOR ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "removes a record from the Director table", :points => 1 do
    director = Director.new
    director.first_name = "Joe"
    director.last_name = "Schmoe"
    director.save

    visit "/backdoor/delete_director/#{director.id}"

    expect(Director.exists?(director.id)).to be(false)
  end
end

describe "/backdoor/delete_director/[DIRECTOR ID]" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_or_request_with_http_basic).and_return(true)
  end

  it "redirects to /backdoor/directors", :points => 1, hint: h("redirect_vs_render") do
    director = Director.new
    director.first_name = "Joe"
    director.last_name = "Schmoe"
    director.save

    visit "/backdoor/delete_director/#{director.id}"

    expect(page).to have_current_path("/backdoor/directors")
  end
end
