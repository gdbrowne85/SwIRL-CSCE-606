Feature: Create Singular Event

  As a user
  I want to create a singular event
  So that it can be saved and displayed in the system

  Background: 
    Given the user is on the home page

  Scenario: Successful creation of a singular event
    When the user clicks on "Create singular event" button
    And the user fills in the event creation form with the following data:
      | Event Name       | Valorant    |
      | Event Venue      | Zachery     |
      | Event Date       | 2023-11-22  |
      | Event Start Time | 18:09       |
      | Event End Time   | 20:09       |
      | Max Capacity     | 100         |
    And the user submits the event creation form
    Then the user should be redirected to the event details page with a unique event ID


