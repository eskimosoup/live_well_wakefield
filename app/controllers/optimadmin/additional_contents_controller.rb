module Optimadmin
  class AdditionalContentsController < Optimadmin::ApplicationController
    before_action :set_additional_content, only: [:show, :edit, :update, :destroy]


    def index
              @additional_contents = ::AdditionalContent.field_order(params[:order])
                                              .field_search(params[:search])
                                              .pagination(params[:page], params[:per_page])
          end

    def show
    end

    def new
      @additional_content = ::AdditionalContent.new
    end

    def edit
    end

    def create
      @additional_content = ::AdditionalContent.new(additional_content_params)
      if @additional_content.save
        redirect_to_index_or_continue_editing(@additional_content)
      else
        render :new
      end
    end

    def update
      if @additional_content.update(additional_content_params)
        redirect_to_index_or_continue_editing(@additional_content)
      else
        render :edit
      end
    end

    def destroy
      @additional_content.destroy
      if @additional_content.errors.present?
        redirect_back(fallback_location: { action: :index }, flash: { error: @additional_content.errors.messages[:base].first })
      else
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::AdditionalContent.model_name.human))
      end
    end

    private

        def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to fallback_location, notice: (flash.present? ? flash[:error] : notice)
    end
    
    def set_additional_content
      @additional_content = ::AdditionalContent.find(params[:id])
    end

    def additional_content_params
      params.require(:additional_content).permit(
        :area, :title, :content, :display
      )
    end
  end
end
