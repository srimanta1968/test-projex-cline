@feature_id:86afad61-1351-49c2-976b-eebd27efb491
@epic_id:6c20f3b7-2283-4538-aee4-310713597085
Feature: Real-Time Ride Matching
  Create a system for real-time matching of riders based on current locations.

  @scenario_id:c6bc98f1-22bf-47ec-abcd-9bfbc60385fb
  @scenario_type:API
  @api_test
  Scenario: Successful Ride Match
    # Scenario ID: c6bc98f1-22bf-47ec-abcd-9bfbc60385fb
    # Feature ID: 86afad61-1351-49c2-976b-eebd27efb491
    # Scenario Type: API
    # Description: Verify that the system successfully matches two riders based on their current locations.
    Given a rider is in a location
    When the rider requests a ride match
    Then the system matches the rider with another rider in close proximity
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=86afad61-1351-49c2-976b-eebd27efb491, scenario_id=c6bc98f1-22bf-47ec-abcd-9bfbc60385fb, type=API

  @scenario_id:dc8409ed-1985-4bb0-9f86-b392efb2e042
  @scenario_type:UI
  @ui_test
  Scenario: No Riders Available
    # Scenario ID: dc8409ed-1985-4bb0-9f86-b392efb2e042
    # Feature ID: 86afad61-1351-49c2-976b-eebd27efb491
    # Scenario Type: UI
    # Description: Verify that the system handles the scenario where no riders are available for matching.
    Given a rider is in a location with no other riders nearby
    When the rider requests a ride match
    Then the system informs the rider that no matches are available
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=86afad61-1351-49c2-976b-eebd27efb491, scenario_id=dc8409ed-1985-4bb0-9f86-b392efb2e042, type=UI

  @scenario_id:72a3216c-8391-4776-b335-3cf24e4f6bfb
  @scenario_type:API
  @api_test
  Scenario: Multiple Riders Available
    # Scenario ID: 72a3216c-8391-4776-b335-3cf24e4f6bfb
    # Feature ID: 86afad61-1351-49c2-976b-eebd27efb491
    # Scenario Type: API
    # Description: Verify the system's ability to match a rider with multiple available riders based on proximity.
    Given a rider is in a location with multiple nearby riders
    When the rider requests a ride match
    Then the system presents the rider with a list of available riders to choose from
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=86afad61-1351-49c2-976b-eebd27efb491, scenario_id=72a3216c-8391-4776-b335-3cf24e4f6bfb, type=API

  @scenario_id:4148cac7-e7c8-4c6e-ade0-bbd05568844b
  @scenario_type:API
  @api_test
  Scenario: Ride Match Cancellation
    # Scenario ID: 4148cac7-e7c8-4c6e-ade0-bbd05568844b
    # Feature ID: 86afad61-1351-49c2-976b-eebd27efb491
    # Scenario Type: API
    # Description: Verify that a rider can cancel a ride match request.
    Given a rider has requested a ride match
    When the rider decides to cancel the ride match
    Then the system confirms the cancellation of the ride match
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=86afad61-1351-49c2-976b-eebd27efb491, scenario_id=4148cac7-e7c8-4c6e-ade0-bbd05568844b, type=API
