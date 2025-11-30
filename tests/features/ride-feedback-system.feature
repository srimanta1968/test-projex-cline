@feature_id:64c4e1ed-9ee9-4465-aec1-1d5b8649e625
@epic_id:2953049b-442f-4464-9bf7-4eab0a6f5d02
Feature: Ride Feedback System
  Develop a feedback system for users to rate their ride experience.

  @scenario_id:83dd1d5b-7d1f-40c1-beea-0ed299fdc46e
  @scenario_type:UI
  @ui_test
  Scenario: User submits feedback after ride completion
    # Scenario ID: 83dd1d5b-7d1f-40c1-beea-0ed299fdc46e
    # Feature ID: 64c4e1ed-9ee9-4465-aec1-1d5b8649e625
    # Scenario Type: UI
    # Description: Test the ability of a user to submit feedback after a ride has been completed.
    Given the user has completed a ride
    When the user navigates to the feedback section of the app
    Then the user submits a rating and a comment
    And a confirmation message is displayed
    And the feedback is saved in the system
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=64c4e1ed-9ee9-4465-aec1-1d5b8649e625, scenario_id=83dd1d5b-7d1f-40c1-beea-0ed299fdc46e, type=UI

  @scenario_id:e65a6741-5482-49f9-84c7-71a98dfe24df
  @scenario_type:UI
  @ui_test
  Scenario: User views previously submitted feedback
    # Scenario ID: e65a6741-5482-49f9-84c7-71a98dfe24df
    # Feature ID: 64c4e1ed-9ee9-4465-aec1-1d5b8649e625
    # Scenario Type: UI
    # Description: Test if a user can view their previously submitted feedback.
    Given the user is logged into the app
    When the user navigates to the feedback history section
    Then the previously submitted feedback is displayed
    And the user can see the rating and comments
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=64c4e1ed-9ee9-4465-aec1-1d5b8649e625, scenario_id=e65a6741-5482-49f9-84c7-71a98dfe24df, type=UI

  @scenario_id:09c33cb9-1b9d-48d6-b882-1b32afc7f755
  @scenario_type:UI
  @ui_test
  Scenario: User attempts to submit feedback without rating
    # Scenario ID: 09c33cb9-1b9d-48d6-b882-1b32afc7f755
    # Feature ID: 64c4e1ed-9ee9-4465-aec1-1d5b8649e625
    # Scenario Type: UI
    # Description: Test the system's response when a user tries to submit feedback without providing a rating.
    Given the user has completed a ride
    When the user navigates to the feedback section of the app
    And the user tries to submit feedback without a rating
    Then an error message is displayed
    And the feedback is not saved
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=64c4e1ed-9ee9-4465-aec1-1d5b8649e625, scenario_id=09c33cb9-1b9d-48d6-b882-1b32afc7f755, type=UI

  @scenario_id:a36d20d6-f359-4937-9817-985c0e53a675
  @scenario_type:UI
  @ui_test
  Scenario: User cancels feedback submission
    # Scenario ID: a36d20d6-f359-4937-9817-985c0e53a675
    # Feature ID: 64c4e1ed-9ee9-4465-aec1-1d5b8649e625
    # Scenario Type: UI
    # Description: Test the ability of a user to cancel feedback submission before it is finalized.
    Given the user is on the feedback submission page
    When the user decides to cancel the feedback
    Then the user is redirected back to the ride summary page
    And no feedback is saved
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=64c4e1ed-9ee9-4465-aec1-1d5b8649e625, scenario_id=a36d20d6-f359-4937-9817-985c0e53a675, type=UI
