class PagesController < ApplicationController
  before_action :set_page

  include PageHelper

  def show
    return redirect_to @page, status: :moved_permanently if request.path != page_path(@page)
    @client_story = @page.service.present? && @page.client_story.blank? ? @page.service.client_stories.order("random()").first : @page.client_story
    @presented_service = ServicePresenter.new(object: @page.service, view_template: view_context) if @page.service
    @presented_contact_detail = ContactDetailPresenter.new(object: @page.service.contact_detail, view_template: view_context) if @page.service && @page.service.contact_detail
    @presented_client_story = ClientStoryPresenter.new(object: @client_story, view_template: view_context) if @client_story
    @side_menus = @page.side_menus
    render layout: @page.layout
  end

  private

    def set_page
      @page = Page.displayed.friendly.find(params[:id])
      @presented_page = PagePresenter.new(object: @page, view_template: view_context)
    end
end
