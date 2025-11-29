@feature_id:2541ad29-6b73-4c18-895a-8940261d7926
@epic_id:43521b9f-734b-4c68-86b9-6b9dc1a82ecb
Feature: Route Planning Engine
  Develop an engine that optimizes routes in real-time for pickups and drop-offs.

  @scenario_id:b323afb4-d9d5-4007-8b62-ec45f70b9561
  @scenario_type:UI
  @ui_test
  Scenario: Optimize Route for Single Pickup and Drop-off
    # Scenario ID: b323afb4-d9d5-4007-8b62-ec45f70b9561
    # Feature ID: 2541ad29-6b73-4c18-895a-8940261d7926
    # Scenario Type: UI
    # Description: Test the route planning engine to ensure it optimizes the route for a single pickup and drop-off in real-time.
    Given the rider app is open
    When the rider inputs a pickup location and a drop-off location
    Then the engine provides the optimized route
    And the estimated time of arrival is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=2541ad29-6b73-4c18-895a-8940261d7926, scenario_id=b323afb4-d9d5-4007-8b62-ec45f70b9561, type=UI

  @scenario_id:6e815208-0d1e-427f-870a-1a078f737b65
  @scenario_type:UI
  @ui_test
  Scenario: Optimize Route for Multiple Pickups
    # Scenario ID: 6e815208-0d1e-427f-870a-1a078f737b65
    # Feature ID: 2541ad29-6b73-4c18-895a-8940261d7926
    # Scenario Type: UI
    # Description: Verify that the route planning engine can handle multiple pickups efficiently.
    Given the rider app is open
    When the rider inputs a primary drop-off location and multiple pickup locations
    Then the engine provides the optimized route for all pickups
    And the estimated time of arrival for each pickup is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=2541ad29-6b73-4c18-895a-8940261d7926, scenario_id=6e815208-0d1e-427f-870a-1a078f737b65, type=UI

  @scenario_id:c4728c8b-774a-470e-95b2-2d8a422f73f0
  @scenario_type:API
  @api_test
  Scenario: Real-time Route Adjustment
    # Scenario ID: c4728c8b-774a-470e-95b2-2d8a422f73f0
    # Feature ID: 2541ad29-6b73-4c18-895a-8940261d7926
    # Scenario Type: API
    # Description: Check if the route planning engine can adjust the route in real-time based on traffic conditions.
    Given the rider app is open and a route is already planned
    When there is a sudden traffic jam on the planned route
    Then the engine recalculates the route in real-time
    And the rider is notified of the new optimized route
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=2541ad29-6b73-4c18-895a-8940261d7926, scenario_id=c4728c8b-774a-470e-95b2-2d8a422f73f0, type=API

  @scenario_id:11dcee2f-c31e-4796-a42c-d97434f5f4cf
  @scenario_type:UI
  @ui_test
  Scenario: Route Planning with Cost Sharing
    # Scenario ID: 11dcee2f-c31e-4796-a42c-d97434f5f4cf
    # Feature ID: 2541ad29-6b73-4c18-895a-8940261d7926
    # Scenario Type: UI
    # Description: Test the engine's ability to optimize routes while considering cost-sharing for multiple riders.
    Given the rider app is open
    When the rider inputs multiple riders' pickup and drop-off locations
    Then the engine provides an optimized route that minimizes cost for all riders
    And the cost-sharing details are displayed to each rider
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=2541ad29-6b73-4c18-895a-8940261d7926, scenario_id=11dcee2f-c31e-4796-a42c-d97434f5f4cf, type=UI
