require "rails_helper"

RSpec.describe ServicePresenter, type: :presenter do
  let(:service) { build(:service) }
  subject(:service_presenter) { ServicePresenter.new(object: service, view_template: view)}

  describe "delegations", :delegation do
    it { should delegate_method(:name).to(:service) }
    it { should delegate_method(:colour).to(:service) }
  end

  describe "standard service" do
    it "returns the Facebook page URL" do
      expect(service_presenter.facebook).to eq(service.facebook_page_url)
    end
  end

  describe "images" do
    describe "no image" do
      it "show_image should return nil" do
        expect(service_presenter.homepage_image).to eq(nil)
        expect(service_presenter.show_image).to eq(nil)
      end
    end

    describe "has image" do
      let(:service) { build(:service_with_image) }
      subject(:service_presenter) { ServicePresenter.new(object: service, view_template: view)}

      it "show_image should not return nil" do
        expect(service_presenter.show_image(alt: service.name)).to eq(image_tag(service.image.show, alt: service.name))
      end

      it "homepage_image should not return nil" do
        expect(service_presenter.homepage_image(alt: service.name)).to eq(image_tag(service.image.homepage, alt: service.name))
      end
    end
  end
end
