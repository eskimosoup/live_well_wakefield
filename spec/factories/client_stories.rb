FactoryGirl.define do
  factory :client_story do
    service
    title "Client story"
    summary "MyText"
    content "<p>Hello world</p>"
    date Date.today
    display true
  end

end
