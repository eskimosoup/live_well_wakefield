# frozen_string_literal: true

class ReferralsController < ApplicationController # :nodoc:
  def new
    @facade = Referrals::NewFacade.new
    @referral = Referral.new
  end

  def create
    @facade = Referrals::NewFacade.new
    @referral = Referral.new(referral_params)
    if verified?(@referral)
      ReferralMailer.new_referral(@referral).deliver_now
      redirect_to new_referral_path,
                  notice: 'Thank you for contacting the Live Well team'
    else
      render :new
    end
  end

  private

  def referral_params
    params.require(:referral).permit(
      :title,
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
      :referral_reason_and_support_needs,
      :consent_confirmation,
      preferred_contact_method: []
    )
  end

  def verified?(referral)
    (Rails.env.development? || verify_recaptcha(model: referral)) && referral.valid?
  end
end
