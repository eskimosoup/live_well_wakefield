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

    it "returns the read more" do
      expect(client_story_presenter.read_more).to eq(link_to 'Read more', service_client_story_path(client_story.service.id, client_story.id), class: "client-story-read-more #{client_story.service.colour}", title: "Read more #{client_story.title}")
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

  describe "images" do
    describe "no image" do
      it "linked index image should return nil" do
        expect(client_story_presenter.linked_index_image).to eq(nil)
      end

      it "index_image should return nil" do
        expect(client_story_presenter.index_image).to eq(nil)
      end

      it "show_image should return nil" do
        expect(client_story_presenter.show_image).to eq(nil)
      end
    end

    describe "has image" do
      let(:client_story) { build(:client_story_with_image) }
      subject(:client_story_presenter) { ClientStoryPresenter.new(object: client_story, view_template: view)}

      it "show_image should not return nil" do
        expect(client_story_presenter.show_image(alt: client_story.title)).to eq(image_tag(client_story.image.show, alt: client_story.title))
      end

      it "linked_index_image should not return nil" do
        expect(client_story_presenter.linked_index_image).to eq(link_to client_story_presenter.index_image(alt: client_story.title, class: 'image-right'), service_client_story_path(client_story.service.id, client_story.id))
      end

      it "index_image should not return nil" do
        expect(client_story_presenter.index_image(alt: client_story.title)).to eq(image_tag(client_story.image.index, alt: client_story.title))
      end
    end
  end

  describe "standard testimonial" do
    let(:client_story) { build(:client_story, content: nil) }
    subject(:client_story_presenter) { ClientStoryPresenter.new(object: client_story, view_template: view)}

    it "returns no read more" do
      expect(client_story_presenter.read_more).to eq(nil)
    end
  end

  describe "standard testimonial with image" do
    let(:client_story) { build(:client_story_with_image, content: nil) }
    subject(:client_story_presenter) { ClientStoryPresenter.new(object: client_story, view_template: view)}

    it "linked_index_image should return image" do
      expect(client_story_presenter.linked_index_image).to eq(client_story_presenter.index_image(alt: client_story.title, class: 'image-right'))
    end
  end
end
