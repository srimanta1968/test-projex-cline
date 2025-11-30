@feature_id:63f8e9d4-76e6-4e41-8b9d-e1acb66108e0
@epic_id:8befdc5a-7c7c-4ee5-8919-ca7d6fa14f91
Feature: Driver Verification
  Create a system for verifying driver identities and vehicle details.

  @scenario_id:95dcfb40-08a9-459b-ba80-b7588e27c1f0
  @scenario_type:UI
  @ui_test
  Scenario: Verify Driver Identity using Government ID
    # Scenario ID: 95dcfb40-08a9-459b-ba80-b7588e27c1f0
    # Feature ID: 63f8e9d4-76e6-4e41-8b9d-e1acb66108e0
    # Scenario Type: UI
    # Description: Ensure that the system can verify a driver's identity using their government-issued ID.
    Given the user is on the driver verification page
    When the user uploads a valid government ID
    Then the system verifies the driver's identity
    And the system displays a confirmation message
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=63f8e9d4-76e6-4e41-8b9d-e1acb66108e0, scenario_id=95dcfb40-08a9-459b-ba80-b7588e27c1f0, type=UI

  @scenario_id:517b08ae-c245-4936-9c5c-8d51d1eaa633
  @scenario_type:UI
  @ui_test
  Scenario: Verify Vehicle Details with License Plate
    # Scenario ID: 517b08ae-c245-4936-9c5c-8d51d1eaa633
    # Feature ID: 63f8e9d4-76e6-4e41-8b9d-e1acb66108e0
    # Scenario Type: UI
    # Description: Verify that the system can check vehicle details using the license plate number.
    Given the user is on the driver verification page
    When the user enters a valid license plate number
    Then the system retrieves vehicle details
    And the system displays the vehicle information
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=63f8e9d4-76e6-4e41-8b9d-e1acb66108e0, scenario_id=517b08ae-c245-4936-9c5c-8d51d1eaa633, type=UI

  @scenario_id:a1e95856-a939-4367-bd34-dfbe866bd95e
  @scenario_type:UI
  @ui_test
  Scenario: Invalid Driver ID Submission
    # Scenario ID: a1e95856-a939-4367-bd34-dfbe866bd95e
    # Feature ID: 63f8e9d4-76e6-4e41-8b9d-e1acb66108e0
    # Scenario Type: UI
    # Description: Test the system's response to invalid driver ID submissions.
    Given the user is on the driver verification page
    When the user uploads an invalid government ID
    Then the system displays an error message
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=63f8e9d4-76e6-4e41-8b9d-e1acb66108e0, scenario_id=a1e95856-a939-4367-bd34-dfbe866bd95e, type=UI

  @scenario_id:7ef4c5ac-59c5-475e-b36d-8856856b4232
  @scenario_type:UI
  @ui_test
  Scenario: Incomplete Vehicle Details Submission
    # Scenario ID: 7ef4c5ac-59c5-475e-b36d-8856856b4232
    # Feature ID: 63f8e9d4-76e6-4e41-8b9d-e1acb66108e0
    # Scenario Type: UI
    # Description: Ensure the system handles incomplete vehicle detail submissions gracefully.
    Given the user is on the driver verification page
    When the user enters incomplete vehicle information
    Then the system displays an error message about missing details
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=63f8e9d4-76e6-4e41-8b9d-e1acb66108e0, scenario_id=7ef4c5ac-59c5-475e-b36d-8856856b4232, type=UI
