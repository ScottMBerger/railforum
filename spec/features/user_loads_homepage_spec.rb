require "rails_helper"

feature "User loads page" do
  scenario "successfully" do
    visit root_path
    
    expect(page).to have_text "Welcome to the Ruby on Rails Forum."
  end
end

describe "the signup process", :type => :feature do
  it "signs me in" do
    visit '/signup'
    within("form") do
      fill_in 'Name', :with => 'scott'
      fill_in 'Username', :with => 'scotet'
      fill_in 'Email', :with => 'scott@email.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Confirmation', :with => 'password'
    end
    click_button 'Create my account'
    expect(page).to have_content 'Your account is setup!'
  end
end