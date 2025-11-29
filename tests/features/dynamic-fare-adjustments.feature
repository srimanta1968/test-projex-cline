@feature_id:0e7449cc-a206-48d9-8d14-e2e87986aff0
@epic_id:43521b9f-734b-4c68-86b9-6b9dc1a82ecb
Feature: Dynamic Fare Adjustments
  Enable dynamic fare adjustments based on demand and supply metrics.

  @scenario_id:edb34570-4ee7-4d97-b682-7effbff052f4
  @scenario_type:API
  @api_test
  Scenario: Dynamic Fare Adjustment Based on High Demand
    # Scenario ID: edb34570-4ee7-4d97-b682-7effbff052f4
    # Feature ID: 0e7449cc-a206-48d9-8d14-e2e87986aff0
    # Scenario Type: API
    # Description: Test the system's ability to increase fares during peak demand periods based on real-time metrics.
    Given the system is monitoring demand and supply metrics
    When the demand for rides increases suddenly
    Then the fare for rides is adjusted dynamically to reflect the increase in demand
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0e7449cc-a206-48d9-8d14-e2e87986aff0, scenario_id=edb34570-4ee7-4d97-b682-7effbff052f4, type=API

  @scenario_id:a1067a65-e959-404c-857d-0c0300af9345
  @scenario_type:API
  @api_test
  Scenario: Dynamic Fare Adjustment During Low Supply
    # Scenario ID: a1067a65-e959-404c-857d-0c0300af9345
    # Feature ID: 0e7449cc-a206-48d9-8d14-e2e87986aff0
    # Scenario Type: API
    # Description: Test the system's ability to increase fares when there are fewer available rides compared to demand.
    Given the system is monitoring demand and supply metrics
    When the number of available rides decreases significantly
    Then the fare for rides is increased to balance the supply and demand
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0e7449cc-a206-48d9-8d14-e2e87986aff0, scenario_id=a1067a65-e959-404c-857d-0c0300af9345, type=API

  @scenario_id:18872840-900e-45c2-8f2b-da131c2b4056
  @scenario_type:API
  @api_test
  Scenario: Fare Adjustment Notification to Riders
    # Scenario ID: 18872840-900e-45c2-8f2b-da131c2b4056
    # Feature ID: 0e7449cc-a206-48d9-8d14-e2e87986aff0
    # Scenario Type: API
    # Description: Ensure that riders are notified of fare adjustments in real time based on demand and supply changes.
    Given a rider is using the app and has a pending ride request
    When the fare is adjusted due to a sudden change in demand
    Then the rider receives a notification about the fare change
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0e7449cc-a206-48d9-8d14-e2e87986aff0, scenario_id=18872840-900e-45c2-8f2b-da131c2b4056, type=API

  @scenario_id:bcdab04b-67f8-4b7b-a266-5b9f83f8fd75
  @scenario_type:UI
  @ui_test
  Scenario: No Fare Adjustment During Stable Demand
    # Scenario ID: bcdab04b-67f8-4b7b-a266-5b9f83f8fd75
    # Feature ID: 0e7449cc-a206-48d9-8d14-e2e87986aff0
    # Scenario Type: UI
    # Description: Verify that fares do not change when demand and supply metrics are stable.
    Given the system is monitoring demand and supply metrics
    When the demand and supply metrics remain stable for a period of time
    Then the fare for rides remains unchanged
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0e7449cc-a206-48d9-8d14-e2e87986aff0, scenario_id=bcdab04b-67f8-4b7b-a266-5b9f83f8fd75, type=UI
