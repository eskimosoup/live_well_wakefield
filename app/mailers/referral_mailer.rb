# frozen_string_literal: true

class ReferralMailer < ApplicationMailer
  def new_referral(referral)
    @referral = referral
    mail to: site_email, subject: "Referral Form Completed #{site_name}"
  end

  def new_waiting_well(referral)
    @referral = referral
    mail to: waiting_well_email, subject: "Waiting Well Form Completed #{site_name}"
  end

  def waiting_well_email
    @site_email = begin
      site_setting = Optimadmin::SiteSetting.where(environment: Rails.env).find_by(key: "Email - Waiting Well")
      if site_setting
        site_setting.value
      else
        site_email
      end
    end
  end
end
