class ContactsController < ApplicationController

  before_action :find_service, only: :create

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid? && @service.present?
      ContactMailer.new_contact(@contact, @service).deliver_now
      redirect_to new_contact_path, notice: "Thank you for contacting the Live Well team"
    elsif @contact.valid?
      ContactMailer.new_contact(@contact, nil).deliver_now
      redirect_to new_contact_path, notice: "Thank you for contacting the Live Well team"
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone_number, :email, :message, :service_id)
  end

    def find_service
      @service = Service.displayed.find(contact_params[:service_id]) if contact_params[:service_id].present?
    end
end
