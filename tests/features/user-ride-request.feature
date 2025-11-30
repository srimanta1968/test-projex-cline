@feature_id:129452a6-f336-4237-ae7c-440dbe7362c5
@epic_id:d13f95eb-7b71-4fbc-90fc-afb8cb89a448
Feature: User Ride Request
  Allow users to request a ride in real-time, providing their current location and destination.

  @scenario_id:88240f84-9b62-445a-8871-b12a5d4558b9
  @scenario_type:UI
  @ui_test
  Scenario: Request a ride with valid location and destination
    # Scenario ID: 88240f84-9b62-445a-8871-b12a5d4558b9
    # Feature ID: 129452a6-f336-4237-ae7c-440dbe7362c5
    # Scenario Type: UI
    # Description: This scenario tests the ability for a user to successfully request a ride when valid information is provided.
    Given the user is logged into the rider app
    When the user inputs their current location and destination
    Then the system processes the ride request
    And the user receives a confirmation of the ride request
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=129452a6-f336-4237-ae7c-440dbe7362c5, scenario_id=88240f84-9b62-445a-8871-b12a5d4558b9, type=UI

  @scenario_id:483a3414-1055-4ef2-88bb-47f96a7401f3
  @scenario_type:UI
  @ui_test
  Scenario: Request a ride without providing destination
    # Scenario ID: 483a3414-1055-4ef2-88bb-47f96a7401f3
    # Feature ID: 129452a6-f336-4237-ae7c-440dbe7362c5
    # Scenario Type: UI
    # Description: This scenario tests the system's response when the user does not provide a destination while requesting a ride.
    Given the user is logged into the rider app
    When the user inputs their current location but leaves the destination blank
    Then the system prompts the user to enter a destination
    And the user is not able to proceed with the ride request
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=129452a6-f336-4237-ae7c-440dbe7362c5, scenario_id=483a3414-1055-4ef2-88bb-47f96a7401f3, type=UI

  @scenario_id:a2f923b4-a70e-4e69-976f-920f9961a7b6
  @scenario_type:UI
  @ui_test
  Scenario: Request a ride with invalid location
    # Scenario ID: a2f923b4-a70e-4e69-976f-920f9961a7b6
    # Feature ID: 129452a6-f336-4237-ae7c-440dbe7362c5
    # Scenario Type: UI
    # Description: This scenario checks how the system handles an invalid current location during a ride request.
    Given the user is logged into the rider app
    When the user inputs an invalid current location
    Then the system displays an error message indicating location not found
    And the user is not able to proceed with the ride request
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=129452a6-f336-4237-ae7c-440dbe7362c5, scenario_id=a2f923b4-a70e-4e69-976f-920f9961a7b6, type=UI

  @scenario_id:5a590d3e-e9f8-42ea-aa20-3400c14bc435
  @scenario_type:UI
  @ui_test
  Scenario: Request a ride with no internet connection
    # Scenario ID: 5a590d3e-e9f8-42ea-aa20-3400c14bc435
    # Feature ID: 129452a6-f336-4237-ae7c-440dbe7362c5
    # Scenario Type: UI
    # Description: This scenario tests the behavior of the system when the user attempts to request a ride without an active internet connection.
    Given the user is logged into the rider app
    When the user inputs their current location and destination without internet connection
    Then the system displays an error message indicating no internet connection
    And the user is not able to proceed with the ride request
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=129452a6-f336-4237-ae7c-440dbe7362c5, scenario_id=5a590d3e-e9f8-42ea-aa20-3400c14bc435, type=UI
