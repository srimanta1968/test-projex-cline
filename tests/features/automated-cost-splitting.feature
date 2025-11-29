@feature_id:6ee365ef-5e61-4c3e-8177-4deb0ed82a64
@epic_id:6c20f3b7-2283-4538-aee4-310713597085
Feature: Automated Cost Splitting
  Enable automated cost-splitting for shared rides based on real-time ride metrics.

  @scenario_id:8bf77bac-dda9-4c60-8820-5a08b94f8d19
  @scenario_type:UI
  @ui_test
  Scenario: Basic Cost Splitting Calculation
    # Scenario ID: 8bf77bac-dda9-4c60-8820-5a08b94f8d19
    # Feature ID: 6ee365ef-5e61-4c3e-8177-4deb0ed82a64
    # Scenario Type: UI
    # Description: Verify that the app correctly calculates the cost split based on real-time metrics for two riders sharing a ride.
    Given two riders are in a shared ride
    When the ride is completed
    Then the app displays the correct cost for each rider
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=6ee365ef-5e61-4c3e-8177-4deb0ed82a64, scenario_id=8bf77bac-dda9-4c60-8820-5a08b94f8d19, type=UI

  @scenario_id:f16c5393-9cb4-4401-be34-cac629a422c3
  @scenario_type:API
  @api_test
  Scenario: Cost Splitting with Variable Ride Metrics
    # Scenario ID: f16c5393-9cb4-4401-be34-cac629a422c3
    # Feature ID: 6ee365ef-5e61-4c3e-8177-4deb0ed82a64
    # Scenario Type: API
    # Description: Check the cost-splitting when ride metrics change during the journey, such as distance or time.
    Given two riders are in a shared ride
    When the ride distance increases due to a detour
    Then the app updates the cost split accordingly
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=6ee365ef-5e61-4c3e-8177-4deb0ed82a64, scenario_id=f16c5393-9cb4-4401-be34-cac629a422c3, type=API

  @scenario_id:ba6d973f-0b40-4422-af1a-4f13725ff055
  @scenario_type:API
  @api_test
  Scenario: Cost Splitting Notification
    # Scenario ID: ba6d973f-0b40-4422-af1a-4f13725ff055
    # Feature ID: 6ee365ef-5e61-4c3e-8177-4deb0ed82a64
    # Scenario Type: API
    # Description: Ensure that both riders receive a notification about their cost split after the ride is completed.
    Given two riders complete a shared ride
    When the ride is completed
    Then both riders receive a notification about their cost split
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=6ee365ef-5e61-4c3e-8177-4deb0ed82a64, scenario_id=ba6d973f-0b40-4422-af1a-4f13725ff055, type=API

  @scenario_id:fc16e521-1395-41a2-bb59-fd9b32bba2e6
  @scenario_type:API
  @api_test
  Scenario: Handling of Ride Cancellations
    # Scenario ID: fc16e521-1395-41a2-bb59-fd9b32bba2e6
    # Feature ID: 6ee365ef-5e61-4c3e-8177-4deb0ed82a64
    # Scenario Type: API
    # Description: Test the system's response to a cancellation of one rider in a shared ride and its impact on cost-splitting.
    Given two riders are in a shared ride
    When one rider cancels the ride
    Then the app notifies the remaining rider about the cancellation and adjusts the cost
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=6ee365ef-5e61-4c3e-8177-4deb0ed82a64, scenario_id=fc16e521-1395-41a2-bb59-fd9b32bba2e6, type=API
