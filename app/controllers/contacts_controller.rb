# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if verified_contact?(@contact)
      ContactMailer.new_contact(@contact).deliver_now
      redirect_to new_contact_path,
                  notice: 'Thank you for contacting the Live Well team'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone_number, :email, :message)
  end

  def verified_contact?(contact)
    (Rails.env.development? || verify_recaptcha(model: contact)) && contact.valid?
  end
end
