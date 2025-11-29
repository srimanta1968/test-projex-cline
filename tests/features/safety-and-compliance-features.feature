@feature_id:58424cdd-d0f7-47a0-bcee-1d34f65ef8be
@epic_id:43521b9f-734b-4c68-86b9-6b9dc1a82ecb
Feature: Safety and Compliance Features
  Integrate safety features and compliance checks into the platform.

  @scenario_id:124109b8-3936-4a5c-8267-0ce97f914a2a
  @scenario_type:UI
  @ui_test
  Scenario: User accesses safety features
    # Scenario ID: 124109b8-3936-4a5c-8267-0ce97f914a2a
    # Feature ID: 58424cdd-d0f7-47a0-bcee-1d34f65ef8be
    # Scenario Type: UI
    # Description: Test that the user can easily access the safety features within the app.
    Given the user is logged into the Rider App
    When the user navigates to the safety features section
    Then the safety features section is displayed correctly
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=58424cdd-d0f7-47a0-bcee-1d34f65ef8be, scenario_id=124109b8-3936-4a5c-8267-0ce97f914a2a, type=UI

  @scenario_id:73074e36-5fe1-4314-a769-b1e645c92bba
  @scenario_type:UI
  @ui_test
  Scenario: Compliance checks during ride sharing
    # Scenario ID: 73074e36-5fe1-4314-a769-b1e645c92bba
    # Feature ID: 58424cdd-d0f7-47a0-bcee-1d34f65ef8be
    # Scenario Type: UI
    # Description: Verify that compliance checks are performed when a rider shares a ride with another user.
    Given the user is logged into the Rider App
    And the user selects a ride to share
    When the user initiates the ride sharing process
    Then the compliance checks are performed successfully
    And the user is notified of the compliance status
    # Priority: high
    # Status: draft
    # Test Runner Info: feature_id=58424cdd-d0f7-47a0-bcee-1d34f65ef8be, scenario_id=73074e36-5fe1-4314-a769-b1e645c92bba, type=UI

  @scenario_id:0d44e2ae-b801-4ded-8bd1-636403237283
  @scenario_type:UI
  @ui_test
  Scenario: Safety feature notifications
    # Scenario ID: 0d44e2ae-b801-4ded-8bd1-636403237283
    # Feature ID: 58424cdd-d0f7-47a0-bcee-1d34f65ef8be
    # Scenario Type: UI
    # Description: Ensure that safety feature notifications are sent to users during a ride.
    Given the user is logged into the Rider App
    And the user is in the middle of a ride
    When a safety alert is triggered
    Then the user receives a safety notification
    And the notification contains relevant safety information
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=58424cdd-d0f7-47a0-bcee-1d34f65ef8be, scenario_id=0d44e2ae-b801-4ded-8bd1-636403237283, type=UI

  @scenario_id:8216e0cf-9a67-4f02-9852-9773abfc28d7
  @scenario_type:UI
  @ui_test
  Scenario: User can report a safety issue
    # Scenario ID: 8216e0cf-9a67-4f02-9852-9773abfc28d7
    # Feature ID: 58424cdd-d0f7-47a0-bcee-1d34f65ef8be
    # Scenario Type: UI
    # Description: Test that users can report safety issues easily through the app.
    Given the user is logged into the Rider App
    And the user is on the ride details page
    When the user selects the option to report a safety issue
    Then the report issue form is displayed
    And the user can submit the safety issue report
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=58424cdd-d0f7-47a0-bcee-1d34f65ef8be, scenario_id=8216e0cf-9a67-4f02-9852-9773abfc28d7, type=UI
