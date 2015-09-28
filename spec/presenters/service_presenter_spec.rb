require "rails_helper"

RSpec.describe ServicePresenter, type: :presenter do
  let(:service) { build(:service) }
  subject(:service_presenter) { ServicePresenter.new(object: service, view_template: view)}

  describe "delegations", :delegation do
    it { should delegate_method(:name).to(:service) }
  end
end
