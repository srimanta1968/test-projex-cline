@feature_id:7ecf8d01-121b-4e7f-abbf-fa51f589a316
@epic_id:4765668d-f9b6-490d-8f56-f2c8ea39ba79
Feature: User Acquisition Campaigns
  Launch marketing campaigns to acquire users effectively.

  @scenario_id:4f680218-1ad2-4b42-b4db-34a1679cd698
  @scenario_type:UI
  @ui_test
  Scenario: Create a New User Acquisition Campaign
    # Scenario ID: 4f680218-1ad2-4b42-b4db-34a1679cd698
    # Feature ID: 7ecf8d01-121b-4e7f-abbf-fa51f589a316
    # Scenario Type: UI
    # Description: Verify that a new user acquisition campaign can be created successfully.
    Given User is logged into the Rider App dashboard
    When User navigates to the 'User Acquisition Campaigns' section
    Then User clicks on 'Create New Campaign' button
    And User fills in all required fields and submits the campaign
    And User receives a confirmation message that the campaign has been created
    # Priority: high
    # Status: draft
    # Test Runner Info: feature_id=7ecf8d01-121b-4e7f-abbf-fa51f589a316, scenario_id=4f680218-1ad2-4b42-b4db-34a1679cd698, type=UI

  @scenario_id:0a0a4ee8-c844-4677-8361-49f3d8363a94
  @scenario_type:UI
  @ui_test
  Scenario: Edit an Existing User Acquisition Campaign
    # Scenario ID: 0a0a4ee8-c844-4677-8361-49f3d8363a94
    # Feature ID: 7ecf8d01-121b-4e7f-abbf-fa51f589a316
    # Scenario Type: UI
    # Description: Ensure that an existing user acquisition campaign can be edited.
    Given User is logged into the Rider App dashboard
    And User has an existing user acquisition campaign to edit
    When User navigates to the 'User Acquisition Campaigns' section
    And User selects an existing campaign to edit
    Then User modifies the campaign details and saves changes
    And User receives a confirmation message that the campaign has been updated
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=7ecf8d01-121b-4e7f-abbf-fa51f589a316, scenario_id=0a0a4ee8-c844-4677-8361-49f3d8363a94, type=UI

  @scenario_id:53c9c759-b171-4ac8-951e-97a79ae8e45e
  @scenario_type:UI
  @ui_test
  Scenario: Delete a User Acquisition Campaign
    # Scenario ID: 53c9c759-b171-4ac8-951e-97a79ae8e45e
    # Feature ID: 7ecf8d01-121b-4e7f-abbf-fa51f589a316
    # Scenario Type: UI
    # Description: Verify that a user acquisition campaign can be deleted.
    Given User is logged into the Rider App dashboard
    And User has an existing user acquisition campaign to delete
    When User navigates to the 'User Acquisition Campaigns' section
    And User selects the campaign to delete
    Then User clicks on 'Delete Campaign' button and confirms deletion
    And User receives a confirmation message that the campaign has been deleted
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=7ecf8d01-121b-4e7f-abbf-fa51f589a316, scenario_id=53c9c759-b171-4ac8-951e-97a79ae8e45e, type=UI

  @scenario_id:c5d4caf9-4fd8-429a-bd0a-454159c3a6b0
  @scenario_type:UI
  @ui_test
  Scenario: View All User Acquisition Campaigns
    # Scenario ID: c5d4caf9-4fd8-429a-bd0a-454159c3a6b0
    # Feature ID: 7ecf8d01-121b-4e7f-abbf-fa51f589a316
    # Scenario Type: UI
    # Description: Ensure that all user acquisition campaigns are displayed correctly.
    Given User is logged into the Rider App dashboard
    When User navigates to the 'User Acquisition Campaigns' section
    Then User sees a list of all active and inactive campaigns
    And User can filter campaigns by status and date
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=7ecf8d01-121b-4e7f-abbf-fa51f589a316, scenario_id=c5d4caf9-4fd8-429a-bd0a-454159c3a6b0, type=UI
