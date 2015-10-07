module Optimadmin
  class ClientStoriesController < Optimadmin::ApplicationController
    before_action :set_client_story, only: [:show, :edit, :update, :destroy]

    edit_images_for ClientStory, [[:image, { show: ['fit', 200, 200], index: ['fit', 200, 200] }]]

    def index
      @client_stories = Optimadmin::BaseCollectionPresenter.new(collection: ClientStory.where('title ILIKE ?', "%#{params[:search]}%").service(params[:service_id]).order(:position).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::ClientStoryPresenter)
    end

    def show
    end

    def new
      @client_story = ClientStory.new
    end

    def edit
    end

    def create
      @client_story = ClientStory.new(client_story_params)
      if @client_story.save
        redirect_to client_stories_url, notice: 'Client story was successfully created.'
      else
        render :new
      end
    end

    def update
      if @client_story.update(client_story_params)
        redirect_to client_stories_url, notice: 'Client story was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @client_story.destroy
      redirect_to client_stories_url, notice: 'Client story was successfully destroyed.'
    end

  private


    def set_client_story
      @client_story = ClientStory.find(params[:id])
    end

    def client_story_params
      params.require(:client_story).permit(:service_id, :title, :summary, :content, :date, :display, :image, :remote_image_url, :image_cache, :remove_image, :home_highlight)
    end
  end
end
