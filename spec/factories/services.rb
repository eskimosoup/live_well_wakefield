FactoryGirl.define do
  factory :service do
    position 1
    name "Service"
    colour 'red'
    facebook_page_url "https://www.facebook.com/facebook"
    display true
    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :service_with_image, traits: [:with_image]
  end

end
