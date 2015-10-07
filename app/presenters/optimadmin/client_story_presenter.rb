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
      service.name
    end

    def service
      client_story.service
    end

    def view_link(nested = nil)
      begin
        h.link_to eye, h.main_app.polymorphic_url([nested, object]), class: 'menu-item-control'
      rescue
        ''
      end
    end

    def edit_link
      h.link_to pencil, h.edit_client_story_path(object.id), class: 'menu-item-control'
    end

    def delete_link
      h.link_to trash_can, h.client_story_path(object.id), method: :delete, data: { confirm: 'Are you sure?' }, class: 'menu-item-control'
    end
  end
end
