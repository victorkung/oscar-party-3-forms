require "rails_helper"

describe "/" do
  it "has a homepage that works", :points => 1 do
    visit "/"

    expect(page.status_code).to eq(200),
      "Expected the homepage to return a 200 status code"
  end
end

describe "/about" do
  it "has an about page that works", :points => 1 do
    visit "/about"

    expect(page.status_code).to eq(200),
      "Expected the about page to return a 200 status code"
  end
end
