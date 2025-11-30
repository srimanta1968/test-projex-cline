@feature_id:ca60c366-4c3c-4c92-ba5f-33679a3e5240
@epic_id:d13f95eb-7b71-4fbc-90fc-afb8cb89a448
Feature: Ride Matching Algorithm
  Create an algorithm that matches users with available rides based on proximity and preferences.

  @scenario_id:e456f316-dd29-4591-8c9a-45fdf547cb46
  @scenario_type:UI
  @ui_test
  Scenario: Match User with Nearby Ride
    # Scenario ID: e456f316-dd29-4591-8c9a-45fdf547cb46
    # Feature ID: ca60c366-4c3c-4c92-ba5f-33679a3e5240
    # Scenario Type: UI
    # Description: This scenario verifies that the algorithm can successfully match a user with a ride that is nearby.
    Given a user is registered on the Rider App
    When the user searches for available rides
    Then the algorithm matches the user with a ride based on proximity
    And the user is shown the details of the matched ride
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=ca60c366-4c3c-4c92-ba5f-33679a3e5240, scenario_id=e456f316-dd29-4591-8c9a-45fdf547cb46, type=UI

  @scenario_id:80c12e57-8638-4e21-82fc-822efa0b3fb3
  @scenario_type:UI
  @ui_test
  Scenario: Match User with Preferred Ride
    # Scenario ID: 80c12e57-8638-4e21-82fc-822efa0b3fb3
    # Feature ID: ca60c366-4c3c-4c92-ba5f-33679a3e5240
    # Scenario Type: UI
    # Description: This scenario ensures that the algorithm respects user preferences when matching rides.
    Given a user is registered on the Rider App
    And the user has set preferences for ride type
    When the user searches for available rides
    Then the algorithm matches the user with a ride that meets their preferences
    And the user is shown the details of the matched ride
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=ca60c366-4c3c-4c92-ba5f-33679a3e5240, scenario_id=80c12e57-8638-4e21-82fc-822efa0b3fb3, type=UI

  @scenario_id:b0187d90-576b-4ad6-82b3-9a504da2fa38
  @scenario_type:API
  @api_test
  Scenario: No Available Rides
    # Scenario ID: b0187d90-576b-4ad6-82b3-9a504da2fa38
    # Feature ID: ca60c366-4c3c-4c92-ba5f-33679a3e5240
    # Scenario Type: API
    # Description: This scenario checks how the algorithm behaves when no rides are available for a user's search.
    Given a user is registered on the Rider App
    When the user searches for available rides in a location with no rides available
    Then the algorithm returns no available rides
    And the user is notified about the lack of available rides
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=ca60c366-4c3c-4c92-ba5f-33679a3e5240, scenario_id=b0187d90-576b-4ad6-82b3-9a504da2fa38, type=API

  @scenario_id:9d2a5c8f-fd84-40a8-bac9-2f994480e891
  @scenario_type:UI
  @ui_test
  Scenario: Multiple Rides Available
    # Scenario ID: 9d2a5c8f-fd84-40a8-bac9-2f994480e891
    # Feature ID: ca60c366-4c3c-4c92-ba5f-33679a3e5240
    # Scenario Type: UI
    # Description: This scenario tests the algorithm's ability to handle multiple ride options and provide the best match.
    Given a user is registered on the Rider App
    When the user searches for available rides
    Then the algorithm matches the user with the most suitable ride based on proximity and preferences
    And the user is shown the details of multiple matched rides
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=ca60c366-4c3c-4c92-ba5f-33679a3e5240, scenario_id=9d2a5c8f-fd84-40a8-bac9-2f994480e891, type=UI
