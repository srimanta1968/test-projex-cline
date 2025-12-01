@feature_id:97a677c4-379c-4554-a22d-57c96dc4585d
@epic_id:d3d67381-e966-4546-882a-8715ca687cb1
Feature: Cost Splitting Mechanism
  Enable automatic calculation and splitting of ride costs among users.

  @scenario_id:002b4050-24cb-49c8-ab52-c0338f60597a
  @scenario_type:API
  @api_test
  Scenario: Automatic Cost Calculation for Two Riders
    # Scenario ID: 002b4050-24cb-49c8-ab52-c0338f60597a
    # Feature ID: 97a677c4-379c-4554-a22d-57c96dc4585d
    # Scenario Type: API
    # Description: Verify that the app can automatically calculate and split ride costs between two riders when they share a ride.
    Given The first rider has booked a ride from point A to point B
    When The second rider joins the ride at point C
    Then The app calculates the total ride cost and splits it equally between both riders
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=97a677c4-379c-4554-a22d-57c96dc4585d, scenario_id=002b4050-24cb-49c8-ab52-c0338f60597a, type=API

  @scenario_id:d986c3c8-7fe3-4bf7-af52-cca686b3c936
  @scenario_type:API
  @api_test
  Scenario: Cost Splitting with Multiple Riders
    # Scenario ID: d986c3c8-7fe3-4bf7-af52-cca686b3c936
    # Feature ID: 97a677c4-379c-4554-a22d-57c96dc4585d
    # Scenario Type: API
    # Description: Verify that the app can correctly split ride costs among three or more riders.
    Given Three riders have booked a ride together from point A to point D
    When One rider leaves the ride at point B
    Then The app recalculates the ride cost and splits the remaining cost between the two riders
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=97a677c4-379c-4554-a22d-57c96dc4585d, scenario_id=d986c3c8-7fe3-4bf7-af52-cca686b3c936, type=API

  @scenario_id:d5642ef5-eba4-4ccd-9c27-c92be792530d
  @scenario_type:UI
  @ui_test
  Scenario: Cost Adjustment When Rider Leaves
    # Scenario ID: d5642ef5-eba4-4ccd-9c27-c92be792530d
    # Feature ID: 97a677c4-379c-4554-a22d-57c96dc4585d
    # Scenario Type: UI
    # Description: Check that the app adjusts the cost correctly when a rider leaves during the journey.
    Given Four riders are in a ride from point A to point E
    When One rider leaves at point C
    Then The app adjusts the cost and informs the remaining riders of their new share
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=97a677c4-379c-4554-a22d-57c96dc4585d, scenario_id=d5642ef5-eba4-4ccd-9c27-c92be792530d, type=UI

  @scenario_id:50d46bde-0b77-40e5-993d-19dbf749cee5
  @scenario_type:API
  @api_test
  Scenario: Cost Sharing Notification
    # Scenario ID: 50d46bde-0b77-40e5-993d-19dbf749cee5
    # Feature ID: 97a677c4-379c-4554-a22d-57c96dc4585d
    # Scenario Type: API
    # Description: Ensure that all riders receive a notification of their cost share after splitting the ride costs.
    Given Two riders have completed a ride from point A to point F
    When The costs have been split between the riders
    Then All riders receive a notification with their individual cost share
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=97a677c4-379c-4554-a22d-57c96dc4585d, scenario_id=50d46bde-0b77-40e5-993d-19dbf749cee5, type=API
