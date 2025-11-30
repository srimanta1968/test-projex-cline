@feature_id:e7adce4a-7afa-42cd-b32a-f2024d0fd2e8
@epic_id:8befdc5a-7c7c-4ee5-8919-ca7d6fa14f91
Feature: User Profile Management
  Allow users to manage their profiles and view ride history.

  @scenario_id:f4402000-8caa-4079-bd2f-0fae5c402975
  @scenario_type:UI
  @ui_test
  Scenario: User can update profile information
    # Scenario ID: f4402000-8caa-4079-bd2f-0fae5c402975
    # Feature ID: e7adce4a-7afa-42cd-b32a-f2024d0fd2e8
    # Scenario Type: UI
    # Description: Verify that users can update their profile information in the app.
    Given the user is logged into the Rider App
    When the user navigates to the profile management section
    Then the user updates their profile information
    And the profile information is successfully updated
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e7adce4a-7afa-42cd-b32a-f2024d0fd2e8, scenario_id=f4402000-8caa-4079-bd2f-0fae5c402975, type=UI

  @scenario_id:edcdb44d-663f-458f-b6d9-249b4ae25d2b
  @scenario_type:UI
  @ui_test
  Scenario: User can view ride history
    # Scenario ID: edcdb44d-663f-458f-b6d9-249b4ae25d2b
    # Feature ID: e7adce4a-7afa-42cd-b32a-f2024d0fd2e8
    # Scenario Type: UI
    # Description: Ensure users can access and view their ride history.
    Given the user is logged into the Rider App
    When the user navigates to the ride history section
    Then the user sees a list of past rides
    And the ride details are displayed correctly
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e7adce4a-7afa-42cd-b32a-f2024d0fd2e8, scenario_id=edcdb44d-663f-458f-b6d9-249b4ae25d2b, type=UI

  @scenario_id:a7a3098b-53b2-49f0-823a-c3df7541567f
  @scenario_type:UI
  @ui_test
  Scenario: User can change profile picture
    # Scenario ID: a7a3098b-53b2-49f0-823a-c3df7541567f
    # Feature ID: e7adce4a-7afa-42cd-b32a-f2024d0fd2e8
    # Scenario Type: UI
    # Description: Check if the user can change their profile picture.
    Given the user is logged into the Rider App
    When the user selects the option to change profile picture
    Then the user uploads a new profile picture
    And the profile picture is updated successfully
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e7adce4a-7afa-42cd-b32a-f2024d0fd2e8, scenario_id=a7a3098b-53b2-49f0-823a-c3df7541567f, type=UI

  @scenario_id:422ba527-40ad-429e-b1f1-ee1e0f7f4977
  @scenario_type:UI
  @ui_test
  Scenario: User can delete their account
    # Scenario ID: 422ba527-40ad-429e-b1f1-ee1e0f7f4977
    # Feature ID: e7adce4a-7afa-42cd-b32a-f2024d0fd2e8
    # Scenario Type: UI
    # Description: Verify that users can delete their account from the app.
    Given the user is logged into the Rider App
    When the user navigates to the account deletion section
    Then the user confirms the account deletion
    And the account is deleted successfully
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e7adce4a-7afa-42cd-b32a-f2024d0fd2e8, scenario_id=422ba527-40ad-429e-b1f1-ee1e0f7f4977, type=UI
