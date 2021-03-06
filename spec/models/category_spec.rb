require "spec_helper"

describe Category do  
  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  
  describe "#recent_videos" do  #how to test an instance method
    it "returns the videos in reverse chronical order by created at" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel in the future!", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy hooligans", category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel in the future!", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy hooligans", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more that 6 videos" do
      comedies = Category.create(name: "comedies")
      7.times {Video.create(title: "foo", description: "blah blah blah", category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedies = Category.create(name: "comedies")
      6.times {Video.create(title: "foo", description: "blah blah blah", category: comedies)}
      tonight_show = Video.create(title: "Tonight Show", description: "not so funny", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonight_show)
    end

    it "returns and empty array if the category does not have any videos" do
      comedies = Category.new(name: "comedies")
      expect(comedies.recent_videos).to eq([])
    end
  end
end