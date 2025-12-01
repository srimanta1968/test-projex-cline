@feature_id:f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07
@epic_id:674e4fc4-232f-4e8c-9991-a83a082b0ef5
Feature: Dynamic Route Adjustment
  Allow the system to adjust routes in real-time based on traffic and rider changes.

  @scenario_id:ff31ac62-1fc0-4052-81b9-918f29f2dbbb
  @scenario_type:API
  @api_test
  Scenario: Adjust route based on real-time traffic
    # Scenario ID: ff31ac62-1fc0-4052-81b9-918f29f2dbbb
    # Feature ID: f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07
    # Scenario Type: API
    # Description: Test if the system can adjust the route in real-time based on traffic updates.
    Given the rider is in transit
    When there is a traffic jam reported on the current route
    Then the system adjusts the route to avoid the traffic jam
    And the rider is notified of the new route
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07, scenario_id=ff31ac62-1fc0-4052-81b9-918f29f2dbbb, type=API

  @scenario_id:a04835eb-5964-42cd-b1e4-ad8d682900d2
  @scenario_type:API
  @api_test
  Scenario: Adjust route for new rider joining
    # Scenario ID: a04835eb-5964-42cd-b1e4-ad8d682900d2
    # Feature ID: f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07
    # Scenario Type: API
    # Description: Test if the system can adjust the route when a new rider joins mid-journey.
    Given the rider is already on a journey
    When a new rider requests to join the ride
    Then the system recalculates the route to include the new rider
    And the original rider is notified of the updated route
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07, scenario_id=a04835eb-5964-42cd-b1e4-ad8d682900d2, type=API

  @scenario_id:45371e96-557c-4357-a6b6-b753cf5f2a17
  @scenario_type:UI
  @ui_test
  Scenario: Remove rider and adjust route
    # Scenario ID: 45371e96-557c-4357-a6b6-b753cf5f2a17
    # Feature ID: f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07
    # Scenario Type: UI
    # Description: Test if the system can adjust the route when a rider leaves the journey.
    Given there are multiple riders in a journey
    When one rider decides to leave the ride
    Then the system updates the route to reflect the removal of the rider
    And the remaining riders are informed of the new route
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07, scenario_id=45371e96-557c-4357-a6b6-b753cf5f2a17, type=UI

  @scenario_id:056be9c0-e0be-4011-967d-5da60cd435b4
  @scenario_type:API
  @api_test
  Scenario: Dynamic route adjustment under extreme traffic conditions
    # Scenario ID: 056be9c0-e0be-4011-967d-5da60cd435b4
    # Feature ID: f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07
    # Scenario Type: API
    # Description: Test if the system can handle extreme traffic conditions and adjust routes accordingly.
    Given the riders are on a scheduled route
    When extreme traffic conditions are reported on the planned route
    Then the system dynamically adjusts the route to minimize delays
    And the riders receive updates on the new estimated arrival time
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=f6c0093a-d37c-4fed-a2a0-6a0fa35cbb07, scenario_id=056be9c0-e0be-4011-967d-5da60cd435b4, type=API
