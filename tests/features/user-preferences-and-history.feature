@feature_id:acae8d6b-8621-46ed-8b20-566a52c66e9c
@epic_id:674e4fc4-232f-4e8c-9991-a83a082b0ef5
Feature: User Preferences and History
  Keep track of user preferences and ride history for personalized experiences.

  @scenario_id:32a67299-b145-4104-b63c-497d2f6c6627
  @scenario_type:UI
  @ui_test
  Scenario: User Preferences Saving
    # Scenario ID: 32a67299-b145-4104-b63c-497d2f6c6627
    # Feature ID: acae8d6b-8621-46ed-8b20-566a52c66e9c
    # Scenario Type: UI
    # Description: Test the ability to save user preferences in the app.
    Given the user has logged into the app
    When the user navigates to the preferences section
    And the user selects their preferred ride type
    And the user saves their preferences
    Then the app saves the user preferences successfully
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=acae8d6b-8621-46ed-8b20-566a52c66e9c, scenario_id=32a67299-b145-4104-b63c-497d2f6c6627, type=UI

  @scenario_id:d392076b-9e57-410b-9f84-4192ccf5d14f
  @scenario_type:UI
  @ui_test
  Scenario: Ride History Tracking
    # Scenario ID: d392076b-9e57-410b-9f84-4192ccf5d14f
    # Feature ID: acae8d6b-8621-46ed-8b20-566a52c66e9c
    # Scenario Type: UI
    # Description: Test the ability to track and display ride history.
    Given the user has completed multiple rides
    When the user navigates to the ride history section
    Then the app displays the list of completed rides
    And the rides include the date, time, and ride type
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=acae8d6b-8621-46ed-8b20-566a52c66e9c, scenario_id=d392076b-9e57-410b-9f84-4192ccf5d14f, type=UI

  @scenario_id:11a758e9-f9ab-4b46-8a11-a9d2eee5853d
  @scenario_type:UI
  @ui_test
  Scenario: Personalized Recommendations Based on History
    # Scenario ID: 11a758e9-f9ab-4b46-8a11-a9d2eee5853d
    # Feature ID: acae8d6b-8621-46ed-8b20-566a52c66e9c
    # Scenario Type: UI
    # Description: Test personalized ride recommendations based on user preferences and history.
    Given the user has saved preferences and ride history
    When the user opens the app
    Then the app shows personalized ride recommendations
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=acae8d6b-8621-46ed-8b20-566a52c66e9c, scenario_id=11a758e9-f9ab-4b46-8a11-a9d2eee5853d, type=UI

  @scenario_id:f52fc9d2-0018-4d76-b532-20a6ec5b5af2
  @scenario_type:UI
  @ui_test
  Scenario: Update User Preferences
    # Scenario ID: f52fc9d2-0018-4d76-b532-20a6ec5b5af2
    # Feature ID: acae8d6b-8621-46ed-8b20-566a52c66e9c
    # Scenario Type: UI
    # Description: Test the ability to update existing user preferences.
    Given the user has saved preferences
    When the user navigates to the preferences section
    And the user updates their preferred ride type
    And the user saves the updated preferences
    Then the app successfully updates the user preferences
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=acae8d6b-8621-46ed-8b20-566a52c66e9c, scenario_id=f52fc9d2-0018-4d76-b532-20a6ec5b5af2, type=UI
