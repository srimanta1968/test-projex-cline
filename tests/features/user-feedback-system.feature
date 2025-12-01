@feature_id:a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d
@epic_id:d3d67381-e966-4546-882a-8715ca687cb1
Feature: User Feedback System
  Gather user feedback on rides to improve service quality.

  @scenario_id:c5dd3321-5826-46ad-80ba-643ad1f01eab
  @scenario_type:UI
  @ui_test
  Scenario: Gather Feedback After Ride Completion
    # Scenario ID: c5dd3321-5826-46ad-80ba-643ad1f01eab
    # Feature ID: a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d
    # Scenario Type: UI
    # Description: Ensure that users can submit feedback after completing a ride.
    Given the user has completed a ride
    When the user navigates to the feedback section
    Then the user is presented with a feedback form
    And the user submits their feedback
    And a confirmation message is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d, scenario_id=c5dd3321-5826-46ad-80ba-643ad1f01eab, type=UI

  @scenario_id:5568f0cf-022c-46d1-9302-c5a3bc1744ae
  @scenario_type:UI
  @ui_test
  Scenario: Submit Feedback Without Ride Completion
    # Scenario ID: 5568f0cf-022c-46d1-9302-c5a3bc1744ae
    # Feature ID: a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d
    # Scenario Type: UI
    # Description: Verify that users cannot submit feedback without completing a ride.
    Given the user is logged into the app
    When the user attempts to access the feedback section
    Then an error message is displayed indicating feedback can only be submitted after a ride
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d, scenario_id=5568f0cf-022c-46d1-9302-c5a3bc1744ae, type=UI

  @scenario_id:9be4f77d-1cdc-4880-a985-287030cccf3d
  @scenario_type:UI
  @ui_test
  Scenario: Provide Anonymous Feedback Option
    # Scenario ID: 9be4f77d-1cdc-4880-a985-287030cccf3d
    # Feature ID: a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d
    # Scenario Type: UI
    # Description: Check if users have the option to provide feedback anonymously.
    Given the user has completed a ride
    When the user navigates to the feedback section
    Then the user sees an option to provide anonymous feedback
    And the user selects the anonymous feedback option
    And the feedback is submitted without revealing user identity
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d, scenario_id=9be4f77d-1cdc-4880-a985-287030cccf3d, type=UI

  @scenario_id:e64fefae-f7f3-48e1-851e-8757938a6663
  @scenario_type:UI
  @ui_test
  Scenario: Rate Ride Experience
    # Scenario ID: e64fefae-f7f3-48e1-851e-8757938a6663
    # Feature ID: a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d
    # Scenario Type: UI
    # Description: Allow users to rate their ride experience on a scale of 1 to 5.
    Given the user has completed a ride
    When the user navigates to the feedback section
    Then the user is prompted to rate their experience from 1 to 5
    And the user selects a rating and submits feedback
    And the rating is recorded in the system
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=a56c75a1-8a6d-4b0c-887e-dee6d29ccb7d, scenario_id=e64fefae-f7f3-48e1-851e-8757938a6663, type=UI
