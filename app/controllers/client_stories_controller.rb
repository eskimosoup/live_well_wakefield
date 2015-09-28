class ClientStoriesController < ApplicationController
  before_action :find_service
  before_action :find_client_story, only: :show

  def index

  end

  def show
    return redirect_to service_client_story_path(@service, @client_story), status: :moved_permanently if request.path != service_client_story_path(@service, @client_story)
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
