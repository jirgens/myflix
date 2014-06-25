require 'spec_helper'

feature "User interacts with the queue" do  
  scenario "user adds and reorders videos in the queue" do  
    comedy = Category.new(name: 'Comedy', created_at: "2014-06-10 18:45:45", updated_at: "2014-06-10 18:45:45")
    monk = Fabricate(:video, title: 'Monk', category: comedy)
    south_park = Fabricate(:video, title: 'South Park', category: comedy)
    futurama = Fabricate(:video, title: 'Futurama', category: comedy)
    sign_in
    
    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    page.should_not have_content "+ My Queue"

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)

    # in capybara fill_in only works with id and lables. using data instead.
    # fill_in "video_#{monk.id}", with: 3
    # fill_in "video_#{south_park.id}", with: 1
    # fill_in "video_#{futurama.id}", with: 2
    find("input[data-video-id='#{south_park.id}']").set(1)
    find("input[data-video-id='#{monk.id}']").set(3)
    find("input[data-video-id='#{futurama.id}']").set(2)
    click_button "Update Instant Queue"
    expect(find("input[data-video-id='#{south_park.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{futurama.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{monk.id}']").value).to eq("3")

    def add_video_to_queue(video)
      visit home_path
      click_on_video_on_home_page(video)
      click_link "+ My Queue"
    end

    def expect_video_to_be_in_queue(video)
      page.should have_content(monk.title)
    end


  end
end

