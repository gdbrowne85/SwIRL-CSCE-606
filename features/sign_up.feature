Feature: Sign Up

  Scenario: Successful Sign-Up
    Given I am on the sign-in page
    When I click on the "Sign-up" link
    And I fill in the "email_field" with "fake@email.com"
    And I fill in the "password_field" with "cucumber_password"
    And I fill in the "password_confirmation_field" with "cucumber_password"
    And I click the "Sign Up" button
