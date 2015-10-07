class ContactMailer < ApplicationMailer

  def new_contact(contact, service)
    @contact = contact
    @service = service
    if service && service.contact_detail.present?
      mail to: service.contact_detail.form_email_addresses.gsub("\n", ',').squish, subject: "Contact Form Completed #{ [site_name, service.name].compact.join(" - ") }"
    else
      mail to: site_email, subject: "Contact Form Completed #{ site_name }"
    end
  end
end
