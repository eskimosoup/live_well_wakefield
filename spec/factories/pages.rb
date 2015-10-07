FactoryGirl.define do
  factory :page do
    title "Page title"
    style "basic"
    layout "application"
    content "<p>test</p>"
    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :page_with_image, traits: [:with_image]
    trait :with_service do
      service
    end
    factory :page_with_service, traits: [:with_service]
  end

end
