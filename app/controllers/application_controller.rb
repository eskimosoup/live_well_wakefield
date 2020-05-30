class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :global_site_settings, :load_objects

  include Optimadmin::ErrorReporting

  def index
    @presented_services = BaseCollectionPresenter.new(collection: Service.positioned.displayed, view_template: view_context, presenter: ServicePresenter)
    @presented_home_client_stories = BaseCollectionPresenter.new(collection: ClientStory.home_highlight.positioned, view_template: view_context, presenter: ClientStoryPresenter)
  end

  def load_objects
    @header_menu = Optimadmin::Menu.new(name: "header")
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end
