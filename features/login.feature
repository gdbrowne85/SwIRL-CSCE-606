Feature: User Login

  Scenario: Successful Login
    Given I am on the login page
    When I fill in the email field with "user@example.com"
    And I fill in the password field with "password"
    And I click "Login" button
    Then I should be redirected to the home page