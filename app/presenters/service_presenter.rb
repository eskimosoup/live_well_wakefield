class ServicePresenter < BasePresenter
  presents :service
  delegate :name, :colour, to: :service

  def facebook
    service.facebook_page_url
  end

  def linked_main_page_name
    h.link_to name, service.main_page
  end
end
