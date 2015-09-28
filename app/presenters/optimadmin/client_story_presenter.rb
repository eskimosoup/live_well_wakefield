module Optimadmin
  class ClientStoryPresenter < Optimadmin::BasePresenter
    presents :client_story
    delegate :title, to: :client_story

    def id
      client_story.id
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def optimadmin_summary
      h.raw client_story.summary
    end

    def service_name
      client_story.service.name
    end
  end
end
