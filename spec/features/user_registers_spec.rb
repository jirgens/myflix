require 'spec_helper'

feature 'User registers' do
  scenario "with valid user info and valid card" do 
    visit register_path
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "12345"
    fill_in "Full Name", with: "Joe Doe"
    click_button "stripe-button"

    

  end
  scenario "with valid user info and invalid card"
  scenario "with valid user info and declined card"
  scenario "with invalid user info and valid card"
  scenario "with invalid user info and invalid card"
  scenario "with invalid user info and declined card"
end