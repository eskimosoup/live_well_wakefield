require "rails_helper"

RSpec.describe ClientStoryPresenter, type: :presenter do
  let(:client_story) { build(:client_story) }
  subject(:client_story_presenter) { ClientStoryPresenter.new(object: client_story, view_template: view)}

  describe "delegations", :delegation do
    it { should delegate_method(:title).to(:client_story) }
  end

  describe "standard client story" do
    it "returns the summary - html escaped" do
      expect(client_story_presenter.summary).to eq(simple_format client_story.summary)
    end

    it "returns the content - html formatted" do
      expect(client_story_presenter.content).to eq(raw client_story.content)
    end

    it "returns the service colour" do
      expect(client_story_presenter.service_colour).to eq(client_story.service.colour)
    end

    describe "date formatting" do
      it "should return the date with default format" do
        expect(client_story_presenter.date).to eq(l client_story.date, format: :default)
      end

      it "should return the date with short format" do
        expect(client_story_presenter.date(:short)).to eq(l client_story.date, format: :short)
      end

      it "should return the date with long format" do
        expect(client_story_presenter.date(:long)).to eq(l client_story.date, format: :long)
      end
    end
  end
end
