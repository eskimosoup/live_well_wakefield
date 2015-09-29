require 'rails_helper'

RSpec.describe Page, type: :model do
  describe "validations", :validation do
    subject(:page) { build(:page) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_uniqueness_of(:title).scoped_to(:service_id).allow_blank.case_insensitive.with_message("already exists for this page") }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.case_insensitive.with_message("is already taken, leave blank to generate automatically") }
  end

  describe "associations", :association do
    it { should belong_to(:service) }
    it { should belong_to(:client_story) }
  end

  describe "scopes", :scope do
    let(:page) { create(:page) }
    let(:hidden_page) { create(:page, display: false) }

    it 'only returns displayed' do
      expect(Page.displayed).not_to include hidden_page
    end
  end

  describe "before save", :callbacks do
    describe "has service" do
      let(:service) { create(:service) }
      let(:page) { create(:page, service: service) }

      it "should callback update page name before save" do
        expect(page).to callback(:update_page_name).before(:save)
      end

      it "should have service name in page name" do
        expect(page.name).to eq("#{page.title} (#{service.name})")
      end
    end

    describe "has client story" do
      let(:client_story) { create(:client_story) }
      let(:page) { create(:page, client_story: client_story) }

      it "should callback update page service before save" do
        expect(page).to callback(:update_service_from_client_story).before(:save)
      end

      it "should callback update page name before save" do
        expect(page).to callback(:update_page_name).before(:save)
      end

      it "should have the service of the client story" do
        expect(page.service).to eq(client_story.service)
      end

      it "should have service name in page name" do
        expect(page.name).to eq("#{page.title} (#{client_story.service.name})")
      end
    end

    describe "does not have service" do
      let(:page) { create(:page) }

      it "should not have service name in page name" do
        expect(page.name).to eq(page.title)
      end
    end
  end

  describe "friendly_id", :friendly_id do
    let(:page) { create(:page) }

    it "creates a slug if title changed" do
      page.title = "My new title"
      expect(page.should_generate_new_friendly_id?).to be true
    end

    it "creates a slug if suggested_url changed" do
      page.suggested_url = "my-new-titled-page"
      expect(page.should_generate_new_friendly_id?).to be true
    end

    it "does not create slug when other attributes changed" do
      page = create(:page)
      page.content = "Gobbledegook"
      expect(page.should_generate_new_friendly_id?).to be false
    end
  end
end
