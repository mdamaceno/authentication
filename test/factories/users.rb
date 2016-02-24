FactoryGirl.define do
  factory :user, class: Authentication::User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password Faker::Internet.password
    status true
  end
end
