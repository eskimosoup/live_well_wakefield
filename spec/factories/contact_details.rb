FactoryGirl.define do
  factory :contact_detail do
    service
    details "<p>My text</p>"
    form_email_addresses "paul@optimised.today"
  end

end
