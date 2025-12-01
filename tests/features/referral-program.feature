@feature_id:001d6795-f806-42b4-955f-0253aefa7a20
@epic_id:43a3dcb9-230e-4ca2-82d8-8f1d26cfef7f
Feature: Referral Program
  Create a referral program to incentivize users to invite friends.

  @scenario_id:b255000a-ae22-473b-8f9d-130df0bd464d
  @scenario_type:UI
  @ui_test
  Scenario: User Can Access Referral Program
    # Scenario ID: b255000a-ae22-473b-8f9d-130df0bd464d
    # Feature ID: 001d6795-f806-42b4-955f-0253aefa7a20
    # Scenario Type: UI
    # Description: Ensure that users can easily find and access the referral program within the app.
    Given the user is logged into the Rider App
    When the user navigates to the referral section
    Then the referral program details are displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=001d6795-f806-42b4-955f-0253aefa7a20, scenario_id=b255000a-ae22-473b-8f9d-130df0bd464d, type=UI

  @scenario_id:431f1c2c-5607-489b-934d-cadaa411e913
  @scenario_type:UI
  @ui_test
  Scenario: User Can Share Referral Link
    # Scenario ID: 431f1c2c-5607-489b-934d-cadaa411e913
    # Feature ID: 001d6795-f806-42b4-955f-0253aefa7a20
    # Scenario Type: UI
    # Description: Verify that users can share their referral link with friends through various platforms.
    Given the user is on the referral program page
    When the user clicks on the 'Share Referral Link' button
    Then the user is presented with sharing options (e.g., social media, email)
    And the referral link is copied to the clipboard
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=001d6795-f806-42b4-955f-0253aefa7a20, scenario_id=431f1c2c-5607-489b-934d-cadaa411e913, type=UI

  @scenario_id:b2311e8e-2f92-4577-a808-60c5bcda2c87
  @scenario_type:API
  @api_test
  Scenario: User Receives Incentive After Successful Referral
    # Scenario ID: b2311e8e-2f92-4577-a808-60c5bcda2c87
    # Feature ID: 001d6795-f806-42b4-955f-0253aefa7a20
    # Scenario Type: API
    # Description: Check that users receive the promised incentive after a referred friend signs up and completes a ride.
    Given the user has shared their referral link
    And the referred friend has signed up and completed a ride
    When the user checks their rewards balance
    Then the incentive is reflected in the user's rewards balance
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=001d6795-f806-42b4-955f-0253aefa7a20, scenario_id=b2311e8e-2f92-4577-a808-60c5bcda2c87, type=API

  @scenario_id:33b61032-c7e4-4a74-a9e1-0aa998d80dde
  @scenario_type:UI
  @ui_test
  Scenario: Referral Program Terms and Conditions Accessible
    # Scenario ID: 33b61032-c7e4-4a74-a9e1-0aa998d80dde
    # Feature ID: 001d6795-f806-42b4-955f-0253aefa7a20
    # Scenario Type: UI
    # Description: Ensure that the terms and conditions of the referral program are easily accessible to users.
    Given the user is on the referral program page
    When the user clicks on the 'Terms and Conditions' link
    Then the terms and conditions document is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=001d6795-f806-42b4-955f-0253aefa7a20, scenario_id=33b61032-c7e4-4a74-a9e1-0aa998d80dde, type=UI
