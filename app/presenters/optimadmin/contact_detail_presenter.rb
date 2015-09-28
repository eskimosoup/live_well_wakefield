module Optimadmin
  class ContactDetailPresenter < Optimadmin::BasePresenter
    presents :contact_detail

    def id
      contact_detail.id
    end

    def title
      contact_detail.service.name
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      h.raw contact_detail.details
    end
  end
end
