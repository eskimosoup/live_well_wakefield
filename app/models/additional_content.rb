# frozen_string_literal: true

class AdditionalContent < ActiveRecord::Base
  include OptimadminScopes

  AREAS = [
    'Contact Us',
    'Referral Form',
    'Waiting Well Form'
  ].freeze

  validates :area, uniqueness: true, inclusion: { in: AREAS }
  validates :title, presence: true

  scope :displayed, -> { where(display: true) }
end
