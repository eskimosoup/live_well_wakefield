module Optimadmin
  class ContactDetailsController < Optimadmin::ApplicationController
    before_action :set_contact_detail, only: [:show, :edit, :update, :destroy]

    def index
      @contact_details = Optimadmin::BaseCollectionPresenter.new(collection: ContactDetail.joins(:service).where('services.name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::ContactDetailPresenter)
    end

    def show
    end

    def new
      @contact_detail = ContactDetail.new
    end

    def edit
    end

    def create
      @contact_detail = ContactDetail.new(contact_detail_params)
      if @contact_detail.save
        redirect_to contact_details_url, notice: 'Contact detail was successfully created.'
      else
        render :new
      end
    end

    def update
      if @contact_detail.update(contact_detail_params)
        redirect_to contact_details_url, notice: 'Contact detail was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @contact_detail.destroy
      redirect_to contact_details_url, notice: 'Contact detail was successfully destroyed.'
    end

  private


    def set_contact_detail
      @contact_detail = ContactDetail.find(params[:id])
    end

    def contact_detail_params
      params.require(:contact_detail).permit(:service_id, :details, :form_email_addresses)
    end
  end
end
