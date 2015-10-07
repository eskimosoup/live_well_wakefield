class ContactDetail < ActiveRecord::Base
  belongs_to :service

  scope :displayed, -> { where(display: true) }

  validates :service_id, presence: true, uniqueness: { message: 'already has a contact detail' }
  validates :details, :form_email_addresses, presence: true
end
