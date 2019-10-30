# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def new_contact(contact)
    @contact = contact
    mail to: site_email, subject: "Contact Form Completed #{site_name}"
  end
end
