Feature: Sign Up Fail

  Scenario: Failed Sign-Up
    Given I am on sign-in page
    When I click the "Sign-up" link
    And I fill the "email_field" with "fake@email.com"
    And I fill the "password_field" with "cucumber_password_1"
    And I fill the "password_confirmation_field" with "cucumber_password_2"
    And I click on the "Sign Up" button
    Then I should see a password confirmation mismatch error