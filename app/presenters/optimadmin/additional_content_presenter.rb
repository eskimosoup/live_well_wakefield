module Optimadmin
  class AdditionalContentPresenter
    include Optimadmin::PresenterMethods

    presents :additional_content
    delegate :area, :id, :title, to: :additional_content
  end
end
