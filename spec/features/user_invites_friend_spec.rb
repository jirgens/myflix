require 'spec_helper'

feature 'User invites friend' do 
  scenario 'User successfully invites friend and invitation is accepted' do
    alice = Fabricate(:user)
    sign_in(alice)

    visit new_invitation_path
    fill_in "Friend's Name", with: "John Bloe"
    fill_in "Friend's Email", with: "joe@example.com"
    fill_in "Message", with: "Hello please join us."
    click_button "Send Invitation"

    open_email "joe@example.com"
    current_email.click_link "Accept this invitation"

    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Bloe"
    click_button "Sign Up"

    fill_in "Email Address", with: "joe@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    click_link "People"
    expect(page).to have_content alice.full_name
    sign_out

    sign_in(alice)
    click_link "People"
    expect(page).to have_content "John Bloe"

    clear_email
  end
end