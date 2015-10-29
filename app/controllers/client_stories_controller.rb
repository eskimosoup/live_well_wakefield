class ClientStoriesController < ApplicationController
  before_action :find_service
  before_action :find_client_story, only: :show

  def index
    return redirect_to service_client_stories_path(@service), status: :moved_permanently if request.path != service_client_stories_path(@service)
    @presented_client_stories = BaseCollectionPresenter.new(collection: @service.client_stories.displayed.positioned.where("content IS NOT NULL AND content <> ''"), view_template: view_context, presenter: ClientStoryPresenter)
    @title = 'Client Stories'
  end

  def testimonials
    return redirect_to service_client_stories_path(@service), status: :moved_permanently if request.path != service_testimonials_path(@service)
    @presented_client_stories = BaseCollectionPresenter.new(collection: @service.client_stories.displayed.positioned.where("content IS NULL or content = ''"), view_template: view_context, presenter: ClientStoryPresenter)
    @title = 'Testimonials'
    render 'client_stories/index'
  end

  def show
    return redirect_to service_client_story_path(@service, @client_story), status: :moved_permanently if request.path != service_client_story_path(@service, @client_story)
    @presented_contact_detail = ContactDetailPresenter.new(object: @service.contact_detail, view_template: view_context) if @service && @service.contact_detail
  end

  private

    def find_service
      @service = Service.displayed.find(params[:service_id])
      @presented_service = ServicePresenter.new(object: @service, view_template: view_context)
    end

    def find_client_story
      @client_story = ClientStory.displayed.find(params[:id])
      @presented_client_story = ClientStoryPresenter.new(object: @client_story, view_template: view_context)
    end
end
