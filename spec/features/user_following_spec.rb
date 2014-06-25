require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
    alice = Fabricate(:user)
    comedy = Category.new(name: 'Comedy', created_at: "2014-06-10 18:45:45", updated_at: "2014-06-10 18:45:45")
    video = Fabricate(:video, category: comedy)
    Fabricate(:review, user: alice, video: video)

    sign_in
    click_on_video_on_home_page(video)

    click_link alice.full_name
    click_link "Follow"
    expect(page).to have_content(alice.full_name)

    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)

  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end