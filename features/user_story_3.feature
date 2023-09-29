
Feature: Add people to the singular event
  As an event organizer
  I want to add people to the singular event on skhedule.com 
  So that I can manage the list of people attending the particular singular event

  Scenario: Navigate to the singular event page
    Given I am on the Main Page
    When I click on the Organizer Button
    Then I should be on the Organizer Page
    And I should see options for Singular Event, Series Event
    When I click on the Singular Event page 
    Then I should see the Singular Event page
    
  Scenario: Create a singular event and add people to this event
    Given I am on the Main Page
    When I click on the Organizer Button
    Then I should be on the Organizer Page
    And I should see options for Singular Event, Series Event
    When I click on the Singular Event page 
    Then I should see the Singular Event page
    Then create an empty event on the Singular Event Page
    And I should see sucessfull event creation on the Singular Event Page

  Scenario: Fill in Details in the Add people to the singular event page
    Given I am on the Organizer Page
    When I click on Singular Event
    Then I should be on the Singular Event Creation Page
    When I click on Add people to the event
    Then I should be on the add people to the event page
    And I fill in the following details:
      | Email        | testemail@gmail.com          |
    Then I click on the Submit Button

  Scenario: Add multiple people to the add people page
    Given I am on the People List Page for the Test Event
    When I add a person with the following email id:
      | Email        | testemail@gmail.com          |
    Then it should add this record to the database and reload the page for the new entry
    When I again add a person with the email id:
      | Email        | testemail2@gmail.com          |
    And I click on the Submit Button
    Then the email details should be saved in the database
