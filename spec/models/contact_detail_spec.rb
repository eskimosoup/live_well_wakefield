require 'rails_helper'

RSpec.describe ContactDetail, type: :model do
  describe "validations", :validation do
    subject(:service) { build(:service) }
    subject(:contact_detail) { build(:contact_detail, service: service) }
    it { should validate_presence_of(:form_email_addresses) }
    it { should validate_presence_of(:details) }
    it { should validate_uniqueness_of(:service_id).with_message("already has a contact detail") }
  end

  describe "associations", :association do
    it { should belong_to(:service) }
  end

  describe "scopes", :scope do
    let(:contact_detail) { create(:contact_detail) }
    let(:hidden_contact_detail) { create(:contact_detail, display: false) }

    it 'only returns displayed' do
      expect(ContactDetail.displayed).not_to include hidden_contact_detail
    end
  end
end
