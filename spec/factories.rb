require 'faker'

FactoryBot.define do
  factory :notification do
    
  end

  factory :search do
    
  end

  factory :user do
    username { Faker::Name.name }
    password { 'password' }
    password_confirmation { 'password' }
    email { Faker::Internet.email }
  end
end
