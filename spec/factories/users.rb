# frozen_string_literal: true

# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { 'organizer@example.com' }
    password { 'securepassword' }
    role { 'organizer' } # assuming your User model has a role attribute
    # add other necessary attributes
  end
end
