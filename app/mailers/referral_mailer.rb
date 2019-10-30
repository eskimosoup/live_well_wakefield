# frozen_string_literal: true

class ReferralMailer < ApplicationMailer
  def new_referral(referral)
    @referral = referral
    mail to: site_email, subject: "Referral Form Completed #{site_name}"
  end
end
