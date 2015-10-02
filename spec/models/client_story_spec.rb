require 'rails_helper'

RSpec.describe ClientStory, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:summary) }
    it { should validate_uniqueness_of(:suggested_url).scoped_to(:service_id).allow_blank.case_insensitive.with_message("is already taken, leave blank to generate automatically") }
  end

  describe "associations", :association do
    it { should belong_to(:service) }
    it { should have_many(:pages) }
  end

  describe "scopes", :scope do
    let(:client_story) { create(:client_story) }
    let(:hidden_client_story) { create(:client_story, display: false) }
    let(:future_client_story) { create(:client_story, display: true, date: Date.today + 7) }
    let(:home_client_story) { create(:client_story, home_highlight: false) }

    it 'only returns displayed' do
      expect(ClientStory.displayed).not_to include hidden_client_story
    end

    it 'only returns home_highlight' do
      expect(ClientStory.home_highlight).not_to include client_story
    end
  end

  describe "friendly_id", :friendly_id do
    let(:client_story) { create(:client_story) }

    it "creates a slug if title changed" do
      client_story.title = "My new title"
      expect(client_story.should_generate_new_friendly_id?).to be true
    end

    it "creates a slug if suggested_url changed" do
      client_story.suggested_url = "my-new-titled-client-story"
      expect(client_story.should_generate_new_friendly_id?).to be true
    end

    it "does not create slug when other attributes changed" do
      client_story = create(:client_story)
      client_story.content = "Gobbledegook"
      expect(client_story.should_generate_new_friendly_id?).to be false
    end
  end
end
