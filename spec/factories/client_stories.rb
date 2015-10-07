FactoryGirl.define do
  factory :client_story do
    service
    id 1
    sequence(:title) {|n| "Client story #{ n }"}
    summary "MyText"
    content "<p>Hello world</p>"
    date Date.today
    display true
    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :client_story_with_image, traits: [:with_image]
  end

end
