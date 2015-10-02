FactoryGirl.define do
  factory :client_story do
    service
    sequence(:title) {|n| "Client story #{ n }"}
    summary "MyText"
    content "<p>Hello world</p>"
    date Date.today
    display true
  end

end
