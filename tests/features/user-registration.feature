@feature_id:27f897bc-b4b6-4dd1-9817-c32af29fcf3c
@epic_id:8befdc5a-7c7c-4ee5-8919-ca7d6fa14f91
Feature: User Registration
  Enable users to register and create profiles within the app.

  @scenario_id:d5771a00-ae98-40bd-bd1b-9e67c5d787b5
  @scenario_type:UI
  @ui_test
  Scenario: Successful User Registration
    # Scenario ID: d5771a00-ae98-40bd-bd1b-9e67c5d787b5
    # Feature ID: 27f897bc-b4b6-4dd1-9817-c32af29fcf3c
    # Scenario Type: UI
    # Description: Test the successful registration of a new user in the Rider App.
    Given the user is on the registration page
    When the user enters valid credentials
    Then the user should be redirected to the profile creation page
    And a success message is displayed
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=27f897bc-b4b6-4dd1-9817-c32af29fcf3c, scenario_id=d5771a00-ae98-40bd-bd1b-9e67c5d787b5, type=UI

  @scenario_id:c07f506c-17ff-44f7-9df8-ad7aa1c79de8
  @scenario_type:UI
  @ui_test
  Scenario: User Registration with Invalid Email
    # Scenario ID: c07f506c-17ff-44f7-9df8-ad7aa1c79de8
    # Feature ID: 27f897bc-b4b6-4dd1-9817-c32af29fcf3c
    # Scenario Type: UI
    # Description: Test the registration process when the user enters an invalid email address.
    Given the user is on the registration page
    When the user enters an invalid email address
    Then an error message is displayed indicating the email is invalid
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=27f897bc-b4b6-4dd1-9817-c32af29fcf3c, scenario_id=c07f506c-17ff-44f7-9df8-ad7aa1c79de8, type=UI

  @scenario_id:da4bea34-7c41-47bd-b1e7-8c125f599b5c
  @scenario_type:UI
  @ui_test
  Scenario: User Registration with Missing Password
    # Scenario ID: da4bea34-7c41-47bd-b1e7-8c125f599b5c
    # Feature ID: 27f897bc-b4b6-4dd1-9817-c32af29fcf3c
    # Scenario Type: UI
    # Description: Test the registration process when the user does not provide a password.
    Given the user is on the registration page
    When the user enters a valid email and leaves the password field blank
    Then an error message is displayed indicating the password is required
    # Priority: high
    # Status: draft
    # Test Runner Info: feature_id=27f897bc-b4b6-4dd1-9817-c32af29fcf3c, scenario_id=da4bea34-7c41-47bd-b1e7-8c125f599b5c, type=UI

  @scenario_id:b174b532-358c-44d6-882c-a2a766874dbe
  @scenario_type:UI
  @ui_test
  Scenario: User Registration with Password Mismatch
    # Scenario ID: b174b532-358c-44d6-882c-a2a766874dbe
    # Feature ID: 27f897bc-b4b6-4dd1-9817-c32af29fcf3c
    # Scenario Type: UI
    # Description: Test the registration process when the user enters mismatched passwords.
    Given the user is on the registration page
    When the user enters valid email and password but a different confirmation password
    Then an error message is displayed indicating the passwords do not match
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=27f897bc-b4b6-4dd1-9817-c32af29fcf3c, scenario_id=b174b532-358c-44d6-882c-a2a766874dbe, type=UI
