class ContactDetailPresenter < BasePresenter
  presents :contact_detail

  def details
    h.raw contact_detail.details
  end
end
