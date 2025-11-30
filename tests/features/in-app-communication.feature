@feature_id:41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5
@epic_id:2953049b-442f-4464-9bf7-4eab0a6f5d02
Feature: In-App Communication
  Create a messaging system for users and drivers to communicate during rides.

  @scenario_id:5f797f86-a21d-465f-820d-259b5eae1a8a
  @scenario_type:UI
  @ui_test
  Scenario: User initiates a message to the driver
    # Scenario ID: 5f797f86-a21d-465f-820d-259b5eae1a8a
    # Feature ID: 41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5
    # Scenario Type: UI
    # Description: This scenario tests whether the user can send a message to the driver during an active ride.
    Given the user has an active ride
    When the user selects the 'message driver' option
    Then the messaging interface opens
    And the user can type and send a message to the driver
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5, scenario_id=5f797f86-a21d-465f-820d-259b5eae1a8a, type=UI

  @scenario_id:765125c9-32b2-4990-872c-54c64be3cb63
  @scenario_type:API
  @api_test
  Scenario: Driver receives a message from the user
    # Scenario ID: 765125c9-32b2-4990-872c-54c64be3cb63
    # Feature ID: 41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5
    # Scenario Type: API
    # Description: This scenario verifies if the driver can receive and respond to messages from the user.
    Given the driver is logged into the app
    And the user has sent a message to the driver
    When the driver checks the messaging section
    Then the driver sees the user's message
    And the driver can reply to the user
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5, scenario_id=765125c9-32b2-4990-872c-54c64be3cb63, type=API

  @scenario_id:066efeba-0c00-439c-9606-afb3d6414d73
  @scenario_type:API
  @api_test
  Scenario: User and Driver exchange messages
    # Scenario ID: 066efeba-0c00-439c-9606-afb3d6414d73
    # Feature ID: 41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5
    # Scenario Type: API
    # Description: This scenario checks the functionality of message exchange between the user and the driver.
    Given the user has sent a message to the driver
    And the driver has received the message
    When the driver replies to the user's message
    Then the user receives the driver's reply
    And the user can continue the conversation
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5, scenario_id=066efeba-0c00-439c-9606-afb3d6414d73, type=API

  @scenario_id:c0dc86d6-6778-4e65-92dc-8a04e0697239
  @scenario_type:UI
  @ui_test
  Scenario: Messaging system UI is responsive
    # Scenario ID: c0dc86d6-6778-4e65-92dc-8a04e0697239
    # Feature ID: 41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5
    # Scenario Type: UI
    # Description: This scenario tests the responsiveness and usability of the messaging interface.
    Given the user has an active ride
    When the user opens the messaging interface
    Then the messaging interface loads without delay
    And the user can navigate through the messages smoothly
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=41a8eee6-e0af-4e0d-b55a-83f9fbe2b2e5, scenario_id=c0dc86d6-6778-4e65-92dc-8a04e0697239, type=UI
