@feature_id:0969aa13-e03d-4273-9ad4-fc17866c43f1
@epic_id:d13f95eb-7b71-4fbc-90fc-afb8cb89a448
Feature: Cost Splitting Feature
  Develop a feature that automatically splits ride costs among passengers.

  @scenario_id:3b29894e-4e2b-4943-ae05-0a462af02fd7
  @scenario_type:API
  @api_test
  Scenario: Automatic Cost Splitting with Two Passengers
    # Scenario ID: 3b29894e-4e2b-4943-ae05-0a462af02fd7
    # Feature ID: 0969aa13-e03d-4273-9ad4-fc17866c43f1
    # Scenario Type: API
    # Description: Test the cost splitting feature when there are two passengers sharing the ride.
    Given the ride has started with two passengers
    When the ride cost is $20
    Then each passenger should see a cost of $10
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0969aa13-e03d-4273-9ad4-fc17866c43f1, scenario_id=3b29894e-4e2b-4943-ae05-0a462af02fd7, type=API

  @scenario_id:9fefd005-40fc-4c3b-99a7-a88748b7e6c1
  @scenario_type:API
  @api_test
  Scenario: Automatic Cost Splitting with Multiple Passengers
    # Scenario ID: 9fefd005-40fc-4c3b-99a7-a88748b7e6c1
    # Feature ID: 0969aa13-e03d-4273-9ad4-fc17866c43f1
    # Scenario Type: API
    # Description: Test the cost splitting feature when there are multiple passengers sharing the ride.
    Given the ride has started with four passengers
    When the ride cost is $40
    Then each passenger should see a cost of $10
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0969aa13-e03d-4273-9ad4-fc17866c43f1, scenario_id=9fefd005-40fc-4c3b-99a7-a88748b7e6c1, type=API

  @scenario_id:7e0944c3-127f-46a5-acbe-254d50a25bef
  @scenario_type:API
  @api_test
  Scenario: Cost Splitting with Additional Passenger
    # Scenario ID: 7e0944c3-127f-46a5-acbe-254d50a25bef
    # Feature ID: 0969aa13-e03d-4273-9ad4-fc17866c43f1
    # Scenario Type: API
    # Description: Test the cost splitting feature when a new passenger joins mid-ride.
    Given the ride has started with three passengers
    And a new passenger joins the ride
    When the total cost of the ride is $30
    Then each passenger should now see a cost of $7.50
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0969aa13-e03d-4273-9ad4-fc17866c43f1, scenario_id=7e0944c3-127f-46a5-acbe-254d50a25bef, type=API

  @scenario_id:d651ffde-ee3b-4a42-8175-3578769706d5
  @scenario_type:API
  @api_test
  Scenario: Cost Adjustment Notification
    # Scenario ID: d651ffde-ee3b-4a42-8175-3578769706d5
    # Feature ID: 0969aa13-e03d-4273-9ad4-fc17866c43f1
    # Scenario Type: API
    # Description: Test that passengers are notified of cost changes when another passenger joins or leaves.
    Given the ride has started with two passengers
    And a new passenger joins the ride
    When the total cost of the ride is $50
    Then all passengers should receive a notification of the new cost of $16.67
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0969aa13-e03d-4273-9ad4-fc17866c43f1, scenario_id=d651ffde-ee3b-4a42-8175-3578769706d5, type=API
