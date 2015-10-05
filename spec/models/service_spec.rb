require 'rails_helper'

RSpec.describe Service, type: :model do
  describe "validations", :validation do
    subject(:service) { build(:service) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:colour) }
    it { should validate_inclusion_of(:colour).in_array(Service::COLOURS) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.case_insensitive.with_message("is already taken, leave blank to generate automatically") }
  end

  describe "associations", :association do
    it { should have_many(:pages) }
    it { should have_many(:client_stories) }
    it { should have_one(:contact_detail) }
  end

  describe "scopes", :scope do
    let(:service) { create(:service) }
    let(:hidden_service) { create(:service, display: false) }

    it 'only returns displayed' do
      expect(Service.displayed).not_to include hidden_service
    end
  end

  describe "friendly_id", :friendly_id do
    let(:service) { create(:service) }

    it "creates a slug if title changed" do
      service.name = "My new name"
      expect(service.should_generate_new_friendly_id?).to be true
    end

    it "creates a slug if suggested_url changed" do
      service.suggested_url = "my-new-name-client-story"
      expect(service.should_generate_new_friendly_id?).to be true
    end

    it "does not create slug when other attributes changed" do
      service = create(:service)
      service.facebook_page_url = "Gobbledegook"
      expect(service.should_generate_new_friendly_id?).to be false
    end
  end
end
