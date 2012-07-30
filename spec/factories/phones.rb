# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    name {Faker::Name.name}
    number {Faker::PhoneNumber.phone_number}
  end
end
