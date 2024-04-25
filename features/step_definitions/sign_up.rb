# frozen_string_literal: true

Given('I am on the sign-in page') do
  visit '/signin' # Change to the path for your sign-in page
end

When('I click on the "Sign-up" link') do
  expect(page).to have_link('Sign-up')
  click_link('Sign-up')
end

And('I fill in the {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I click the {string} button') do |button_text|
  click_button(button_text)
end
