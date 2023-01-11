module WaitingWells
  class NewFacade
    def additional_content
      @additional_content ||= AdditionalContent.displayed.find_by(area: 'Waiting Well Form')
    end

    def additional_content?
      additional_content.present?
    end
  end
end
