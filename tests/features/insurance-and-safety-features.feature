@feature_id:d429a613-3781-465e-b074-e2abf5dc59a5
@epic_id:674e4fc4-232f-4e8c-9991-a83a082b0ef5
Feature: Insurance and Safety Features
  Incorporate safety measures and insurance options for shared rides.

  @scenario_id:f794b90e-2965-4c6c-aabb-5aa1eb71ca44
  @scenario_type:UI
  @ui_test
  Scenario: Verify Safety Features in Shared Ride
    # Scenario ID: f794b90e-2965-4c6c-aabb-5aa1eb71ca44
    # Feature ID: d429a613-3781-465e-b074-e2abf5dc59a5
    # Scenario Type: UI
    # Description: Test the implementation of safety features in the shared ride option of the Rider App.
    Given the user is on the shared ride selection screen
    When the user selects a shared ride option
    Then the safety features such as emergency contact and ride tracking are visible
    And the user can access safety instructions
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=d429a613-3781-465e-b074-e2abf5dc59a5, scenario_id=f794b90e-2965-4c6c-aabb-5aa1eb71ca44, type=UI

  @scenario_id:7509d5f6-7aa6-4f97-b50d-5b58120c5d6e
  @scenario_type:UI
  @ui_test
  Scenario: Check Insurance Options Availability
    # Scenario ID: 7509d5f6-7aa6-4f97-b50d-5b58120c5d6e
    # Feature ID: d429a613-3781-465e-b074-e2abf5dc59a5
    # Scenario Type: UI
    # Description: Ensure the user can view and select insurance options while booking a shared ride.
    Given the user is on the ride booking screen
    When the user chooses to book a shared ride
    Then the insurance options are displayed for selection
    And the user can select an insurance option
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=d429a613-3781-465e-b074-e2abf5dc59a5, scenario_id=7509d5f6-7aa6-4f97-b50d-5b58120c5d6e, type=UI

  @scenario_id:bedf950a-4b5b-4d19-a91c-3976ef77a219
  @scenario_type:UI
  @ui_test
  Scenario: Verify Cost Sharing Calculation
    # Scenario ID: bedf950a-4b5b-4d19-a91c-3976ef77a219
    # Feature ID: d429a613-3781-465e-b074-e2abf5dc59a5
    # Scenario Type: UI
    # Description: Test the cost-sharing calculation in the shared ride feature with insurance options included.
    Given the user has selected a shared ride with insurance
    When the user confirms their ride
    Then the cost-sharing amount is calculated correctly
    And the total cost includes selected insurance
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=d429a613-3781-465e-b074-e2abf5dc59a5, scenario_id=bedf950a-4b5b-4d19-a91c-3976ef77a219, type=UI

  @scenario_id:1c2ad54a-e50e-485d-9630-38cc71bbdbff
  @scenario_type:UI
  @ui_test
  Scenario: Ensure User Can Report Safety Issues
    # Scenario ID: 1c2ad54a-e50e-485d-9630-38cc71bbdbff
    # Feature ID: d429a613-3781-465e-b074-e2abf5dc59a5
    # Scenario Type: UI
    # Description: Test the functionality for users to report safety issues during a shared ride.
    Given the user is in an active shared ride
    When the user encounters a safety issue
    Then the user can report the issue through the app
    And the report is sent to support for review
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=d429a613-3781-465e-b074-e2abf5dc59a5, scenario_id=1c2ad54a-e50e-485d-9630-38cc71bbdbff, type=UI
