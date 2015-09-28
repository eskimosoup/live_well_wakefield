module Optimadmin
  class ServicePresenter < Optimadmin::BasePresenter
    presents :service

    def id
      service.id
    end

    def name
      service.name
    end

    def toggle_title
      inline_detail_toggle_link(name)
    end

    def optimadmin_summary
      h.raw service.summary
    end
  end
end
