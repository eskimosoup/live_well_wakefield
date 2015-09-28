require 'rails_helper'

RSpec.describe ClientStory, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:summary) }
    it { should validate_uniqueness_of(:suggested_url).scoped_to(:service_id).allow_blank.case_insensitive.with_message("is already taken, leave blank to generate automatically") }
  end

  describe "associations", :association do
    it { should belong_to(:service) }
  end

  describe "scopes", :scope do
    let(:client_story) { create(:client_story) }
    let(:hidden_client_story) { create(:client_story, display: false) }
    let(:future_client_story) { create(:client_story, display: true, date: Date.today + 7) }

    it 'only returns displayed' do
      expect(ClientStory.displayed).not_to include hidden_client_story
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
