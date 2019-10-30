# frozen_string_literal: true

class Contact
  include ActiveModel::Model

  attr_accessor :name, :phone_number, :email, :message

  validates :name, :message, presence: true
  validates :phone_number, presence: true, if: 'email.blank?'
  validates :email, presence: true, if: 'phone_number.blank?'
end
