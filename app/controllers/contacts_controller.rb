class ContactsController < ApplicationController

  before_action :find_service, only: :create

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if verified_contact?(@contact)
      ContactMailer.new_contact(@contact, current_service(@service)).deliver_now
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

  def verified_contact?(contact)
    verify_recaptcha(model: contact) && contact.valid?
  end

  def current_service(service)
    service.present? ? service : nil
  end
end
