@feature_id:45efea0a-c954-4081-86ca-d516038abfe0
@epic_id:43a3dcb9-230e-4ca2-82d8-8f1d26cfef7f
Feature: Social Media Integration
  Integrate social media sharing features to increase visibility and engagement.

  @scenario_id:a42f3cb8-1883-4d33-9eb5-bef4ca1801bb
  @scenario_type:UI
  @ui_test
  Scenario: Share Ride on Facebook
    # Scenario ID: a42f3cb8-1883-4d33-9eb5-bef4ca1801bb
    # Feature ID: 45efea0a-c954-4081-86ca-d516038abfe0
    # Scenario Type: UI
    # Description: Verify that a user can share their ride details on Facebook during the journey.
    Given the user is logged into the Rider App
    When the user selects the 'Share on Facebook' option
    Then the ride details are pre-filled in the Facebook share dialog
    And the user can post the ride details to their Facebook timeline
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=45efea0a-c954-4081-86ca-d516038abfe0, scenario_id=a42f3cb8-1883-4d33-9eb5-bef4ca1801bb, type=UI

  @scenario_id:1cc7a5c0-1d8f-43d8-8716-6068c5121257
  @scenario_type:UI
  @ui_test
  Scenario: Share Ride on Twitter
    # Scenario ID: 1cc7a5c0-1d8f-43d8-8716-6068c5121257
    # Feature ID: 45efea0a-c954-4081-86ca-d516038abfe0
    # Scenario Type: UI
    # Description: Check if a user can share their ride information on Twitter.
    Given the user is logged into the Rider App
    When the user clicks on the 'Share on Twitter' button
    Then the ride information is displayed in the Twitter share compose window
    And the user can tweet the ride information
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=45efea0a-c954-4081-86ca-d516038abfe0, scenario_id=1cc7a5c0-1d8f-43d8-8716-6068c5121257, type=UI

  @scenario_id:1f056dc7-801f-4579-99f0-3be57fff995d
  @scenario_type:UI
  @ui_test
  Scenario: Share Ride on Instagram
    # Scenario ID: 1f056dc7-801f-4579-99f0-3be57fff995d
    # Feature ID: 45efea0a-c954-4081-86ca-d516038abfe0
    # Scenario Type: UI
    # Description: Ensure that a user can share their ride journey on Instagram stories.
    Given the user is logged into the Rider App
    When the user taps on the 'Share on Instagram' option
    Then the ride details are formatted for Instagram stories
    And the user can post the ride to their Instagram story
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=45efea0a-c954-4081-86ca-d516038abfe0, scenario_id=1f056dc7-801f-4579-99f0-3be57fff995d, type=UI

  @scenario_id:931f5089-0ba1-4653-b229-8788a41fb756
  @scenario_type:UI
  @ui_test
  Scenario: Social Media Share Button Visibility
    # Scenario ID: 931f5089-0ba1-4653-b229-8788a41fb756
    # Feature ID: 45efea0a-c954-4081-86ca-d516038abfe0
    # Scenario Type: UI
    # Description: Verify that social media share buttons are visible on the ride detail page.
    Given the user is on the ride details page
    When the user views the ride details
    Then the Facebook share button is visible
    And the Twitter share button is visible
    And the Instagram share button is visible
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=45efea0a-c954-4081-86ca-d516038abfe0, scenario_id=931f5089-0ba1-4653-b229-8788a41fb756, type=UI
