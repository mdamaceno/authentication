FactoryGirl.define do
  factory :user, class: Authentication::User do
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    email Faker::Internet.email
  end
end
