# frozen_string_literal: true

#
# Custom referral contact form
#
class Referral
  include ActiveModel::Model

  attr_accessor :title,
                :first_name,
                :last_name,
                :date_of_birth,
                :phone_number,
                :email_address,
                :address,
                :postcode,
                :registered_gp_practice,
                :referred_by,
                :referree_name_person,
                :referree_name_professional,
                :referree_relationship,
                :referree_job_title,
                :referree_work_address,
                :referree_contact_number,
                :preferred_contact_method,
                :referral_reason_and_support_needs,
                :consent_confirmation

  REFERS = [
    'Self/Carer/Friend/Family',
    'Professional'
  ].freeze

  PREFERED_CONTACT_METHOD = [
    ['Phone', 'Phone'],
    ['Letter', 'Letter'],
    ['Email', 'Email'],
    ['Text message', 'Text message']
  ].freeze

  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :phone_number, presence: true
  validates :email_address, email: true, if: proc { preferred_contact_method == 'Email' }
  validates :address, presence: true
  validates :postcode, presence: true
  validates :registered_gp_practice, presence: true
  validate :preferred_contact_method_inclusion
  validates :referred_by, presence: true
  validates :referree_name_person, presence: true, if: proc { referred_by == 'Self/Carer/Friend/Family' }
  validates :referree_name_professional, presence: true, if: proc { referred_by == 'Professional' }
  validates :referree_relationship, presence: true, if: proc { referred_by == 'Self/Carer/Friend/Family' }
  validates :referree_job_title, presence: true, if: proc { referred_by == 'Professional' }
  validates :referree_work_address, presence: true, if: proc { referred_by == 'Professional' }
  validates :referree_contact_number, presence: true, if: proc { referred_by == 'Professional' }
  validates :referral_reason_and_support_needs, presence: true
  validate :consent_confirmation_acceptance

  def preferred_contact_method_inclusion
    errors.add(:preferred_contact_method, 'must have at least one option ticked') unless preferred_contact_method.reject(&:blank?).present?
  end

  def consent_confirmation_acceptance
    errors.add(:consent_confirmation, 'must be ticked to continue') unless consent_confirmation == '1'
  end
end
