# frozen_string_literal: true

Given('I am on sign-in page') do
  visit '/signin' # Change to the path for your sign-in page
end

When('I click the "Sign-up" link') do
  expect(page).to have_link('Sign-up')
  click_link('Sign-up')
end

And('I fill the {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I click on the {string} button') do |button_text|
  click_button(button_text)
end

Then('I should see a password confirmation mismatch error') do
  expect(page).to have_text("Password confirmation doesn't match")
end
