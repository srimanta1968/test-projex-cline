@feature_id:35e4f2e9-5988-4198-851b-3102b4ab8dd8
@epic_id:2953049b-442f-4464-9bf7-4eab0a6f5d02
Feature: Real-Time Ride Tracking
  Enable users to track their rides in real-time via GPS.

  @scenario_id:11cad5c4-0cb0-4796-a946-1ffe2eda1923
  @scenario_type:UI
  @ui_test
  Scenario: User initiates ride tracking
    # Scenario ID: 11cad5c4-0cb0-4796-a946-1ffe2eda1923
    # Feature ID: 35e4f2e9-5988-4198-851b-3102b4ab8dd8
    # Scenario Type: UI
    # Description: Ensure that the user can start tracking their ride in real-time using GPS.
    Given the user is logged into the Rider App
    When the user clicks on the 'Start Tracking' button
    Then the ride tracking should begin and display the user's current location
    And the user should see the ride's estimated arrival time
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=35e4f2e9-5988-4198-851b-3102b4ab8dd8, scenario_id=11cad5c4-0cb0-4796-a946-1ffe2eda1923, type=UI

  @scenario_id:cbc5873c-2d73-4be1-a0f4-dbff5a0d76ad
  @scenario_type:UI
  @ui_test
  Scenario: User views ride status
    # Scenario ID: cbc5873c-2d73-4be1-a0f4-dbff5a0d76ad
    # Feature ID: 35e4f2e9-5988-4198-851b-3102b4ab8dd8
    # Scenario Type: UI
    # Description: Check if the user can view the current status of their ride while being tracked.
    Given the user has a ride in progress
    When the user navigates to the ride tracking screen
    Then the current location of the vehicle should be displayed on the map
    And the user should see the expected time of arrival (ETA)
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=35e4f2e9-5988-4198-851b-3102b4ab8dd8, scenario_id=cbc5873c-2d73-4be1-a0f4-dbff5a0d76ad, type=UI

  @scenario_id:305a0e07-73b3-437f-b3e3-ddc0776c3f5c
  @scenario_type:UI
  @ui_test
  Scenario: User stops ride tracking
    # Scenario ID: 305a0e07-73b3-437f-b3e3-ddc0776c3f5c
    # Feature ID: 35e4f2e9-5988-4198-851b-3102b4ab8dd8
    # Scenario Type: UI
    # Description: Verify that the user can stop tracking their ride.
    Given the user is tracking a ride
    When the user clicks on the 'Stop Tracking' button
    Then the ride tracking should stop
    And the user should receive a confirmation message
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=35e4f2e9-5988-4198-851b-3102b4ab8dd8, scenario_id=305a0e07-73b3-437f-b3e3-ddc0776c3f5c, type=UI

  @scenario_id:562b31b3-b7c6-4fa4-8419-9b9262f04458
  @scenario_type:UI
  @ui_test
  Scenario: User shares ride tracking link
    # Scenario ID: 562b31b3-b7c6-4fa4-8419-9b9262f04458
    # Feature ID: 35e4f2e9-5988-4198-851b-3102b4ab8dd8
    # Scenario Type: UI
    # Description: Ensure that the user can share their ride tracking link with another rider.
    Given the user is tracking a ride
    When the user clicks on the 'Share Tracking Link' button
    Then the user should be able to share the link through various platforms
    And the recipients should be able to view the user's real-time location
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=35e4f2e9-5988-4198-851b-3102b4ab8dd8, scenario_id=562b31b3-b7c6-4fa4-8419-9b9262f04458, type=UI
