class ServicePresenter < BasePresenter
  presents :service
  delegate :name, :colour, to: :service

  def facebook
    service.facebook_page_url
  end
end
