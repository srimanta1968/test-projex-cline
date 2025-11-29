@feature_id:367c5596-b427-4676-9984-2127bbf9de17
@epic_id:6c20f3b7-2283-4538-aee4-310713597085
Feature: User Verification & Onboarding
  Implement user verification processes to ensure safety and reliability of users.

  @scenario_id:786fb4c3-8fbe-4104-b370-df103c2a3654
  @scenario_type:UI
  @ui_test
  Scenario: User Registration with Email Verification
    # Scenario ID: 786fb4c3-8fbe-4104-b370-df103c2a3654
    # Feature ID: 367c5596-b427-4676-9984-2127bbf9de17
    # Scenario Type: UI
    # Description: Ensure that users can register with their email and receive a verification link to activate their account.
    Given the user is on the registration page
    When the user enters a valid email and password
    Then the user receives a verification email
    And the account is not activated until the user clicks the verification link
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=367c5596-b427-4676-9984-2127bbf9de17, scenario_id=786fb4c3-8fbe-4104-b370-df103c2a3654, type=UI

  @scenario_id:4f931463-13c9-42a2-93c8-22cae48c2781
  @scenario_type:UI
  @ui_test
  Scenario: User Registration with Phone Verification
    # Scenario ID: 4f931463-13c9-42a2-93c8-22cae48c2781
    # Feature ID: 367c5596-b427-4676-9984-2127bbf9de17
    # Scenario Type: UI
    # Description: Ensure that users can register using their phone number and receive an SMS verification code.
    Given the user is on the registration page
    When the user enters a valid phone number
    Then the user receives an SMS with a verification code
    And the account is not activated until the user enters the verification code
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=367c5596-b427-4676-9984-2127bbf9de17, scenario_id=4f931463-13c9-42a2-93c8-22cae48c2781, type=UI

  @scenario_id:95bec0ba-6efb-4eeb-b22b-ac01ee243ef8
  @scenario_type:UI
  @ui_test
  Scenario: User Profile Update After Verification
    # Scenario ID: 95bec0ba-6efb-4eeb-b22b-ac01ee243ef8
    # Feature ID: 367c5596-b427-4676-9984-2127bbf9de17
    # Scenario Type: UI
    # Description: Verify that users can update their profile information only after successful verification.
    Given the user has completed the email verification
    When the user navigates to the profile update section
    And the user updates their profile information
    Then the profile is updated successfully
    And the user receives a confirmation message
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=367c5596-b427-4676-9984-2127bbf9de17, scenario_id=95bec0ba-6efb-4eeb-b22b-ac01ee243ef8, type=UI

  @scenario_id:4e2551d6-6d3c-4ad6-82d0-cece9b3305f5
  @scenario_type:UI
  @ui_test
  Scenario: Failed Verification Attempts Logging
    # Scenario ID: 4e2551d6-6d3c-4ad6-82d0-cece9b3305f5
    # Feature ID: 367c5596-b427-4676-9984-2127bbf9de17
    # Scenario Type: UI
    # Description: Ensure that failed verification attempts are logged for security purposes.
    Given the user attempts to verify their account with an invalid code
    When the user enters an incorrect verification code
    Then the system logs the failed attempt
    And the user is informed of the failed verification
    # Priority: high
    # Status: draft
    # Test Runner Info: feature_id=367c5596-b427-4676-9984-2127bbf9de17, scenario_id=4e2551d6-6d3c-4ad6-82d0-cece9b3305f5, type=UI
