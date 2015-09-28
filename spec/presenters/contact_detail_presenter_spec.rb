require "rails_helper"

RSpec.describe ContactDetailPresenter, type: :presenter do
  let(:contact_detail) { build(:contact_detail) }
  subject(:contact_detail_presenter) { ContactDetailPresenter.new(object: contact_detail, view_template: view)}

  describe "standard contact detail" do
    it "returns the details - html formatted" do
      expect(contact_detail_presenter.details).to eq(raw contact_detail.details)
    end
  end
end
