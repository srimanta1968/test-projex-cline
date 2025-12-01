@feature_id:477920a6-12d8-4820-b8ef-0926453337a3
@epic_id:43a3dcb9-230e-4ca2-82d8-8f1d26cfef7f
Feature: Loyalty Program
  Implement a loyalty program to reward frequent users of the platform.

  @scenario_id:df43a88f-3ab5-4f75-a47a-82d512b3baae
  @scenario_type:API
  @api_test
  Scenario: User earns loyalty points after each ride
    # Scenario ID: df43a88f-3ab5-4f75-a47a-82d512b3baae
    # Feature ID: 477920a6-12d8-4820-b8ef-0926453337a3
    # Scenario Type: API
    # Description: As a frequent user, I want to earn loyalty points for every ride I take, so that I can redeem them for rewards.
    Given the user is logged into their account
    When the user completes a ride
    Then the user's loyalty points are updated accordingly
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=477920a6-12d8-4820-b8ef-0926453337a3, scenario_id=df43a88f-3ab5-4f75-a47a-82d512b3baae, type=API

  @scenario_id:fff47b2c-739b-4263-ae05-25db2e59622a
  @scenario_type:UI
  @ui_test
  Scenario: User can view loyalty points balance
    # Scenario ID: fff47b2c-739b-4263-ae05-25db2e59622a
    # Feature ID: 477920a6-12d8-4820-b8ef-0926453337a3
    # Scenario Type: UI
    # Description: As a user, I want to be able to view my current loyalty points balance in the app, so that I know how close I am to earning rewards.
    Given the user is logged into their account
    When the user navigates to the loyalty program section
    Then the user's loyalty points balance is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=477920a6-12d8-4820-b8ef-0926453337a3, scenario_id=fff47b2c-739b-4263-ae05-25db2e59622a, type=UI

  @scenario_id:73792b76-7456-4686-ad4d-c6d9af805048
  @scenario_type:UI
  @ui_test
  Scenario: User redeems loyalty points for rewards
    # Scenario ID: 73792b76-7456-4686-ad4d-c6d9af805048
    # Feature ID: 477920a6-12d8-4820-b8ef-0926453337a3
    # Scenario Type: UI
    # Description: As a user, I want to redeem my loyalty points for rewards to enjoy benefits from the loyalty program.
    Given the user has sufficient loyalty points
    When the user selects a reward to redeem
    Then the loyalty points are deducted from the user's account
    And the user receives the selected reward
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=477920a6-12d8-4820-b8ef-0926453337a3, scenario_id=73792b76-7456-4686-ad4d-c6d9af805048, type=UI

  @scenario_id:827b86fc-5ed8-4aef-9d99-16319be37dd2
  @scenario_type:UI
  @ui_test
  Scenario: User receives notifications for loyalty points updates
    # Scenario ID: 827b86fc-5ed8-4aef-9d99-16319be37dd2
    # Feature ID: 477920a6-12d8-4820-b8ef-0926453337a3
    # Scenario Type: UI
    # Description: As a user, I want to receive notifications when my loyalty points are updated, so that I stay informed about my rewards.
    Given the user is logged into their account
    When the user completes a ride or redeems points
    Then the user receives a notification about the loyalty points update
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=477920a6-12d8-4820-b8ef-0926453337a3, scenario_id=827b86fc-5ed8-4aef-9d99-16319be37dd2, type=UI
