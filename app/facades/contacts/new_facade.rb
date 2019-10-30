module Contacts
  class NewFacade
    def additional_content
      @additional_content ||= AdditionalContent.displayed.find_by(area: 'Contact Us')
    end

    def additional_content?
      additional_content.present?
    end
  end
end
