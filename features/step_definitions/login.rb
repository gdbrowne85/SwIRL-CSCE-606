# frozen_string_literal: true

Given('I am on the login page') do
  visit '/signin' # adjust URL to match your app's login path
end

When('I fill in the email field with {string}') do |email|
  fill_in 'email', with: email # adjust if the email input has a different label or id
end

When('I fill in the password field with {string}') do |password|
  fill_in 'password', with: password # adjust if the password input has a different label or id
end

When('I click "Login" button') do
  click_button 'Login'
end

Then('I should be redirected to the home page') do
  visit '/static_pages/home'
end
