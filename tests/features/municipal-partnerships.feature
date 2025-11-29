@feature_id:0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00
@epic_id:4765668d-f9b6-490d-8f56-f2c8ea39ba79
Feature: Municipal Partnerships
  Establish partnerships with municipalities for route data access.

  @scenario_id:655e595b-2367-4209-830e-5168beee82f6
  @scenario_type:UI
  @ui_test
  Scenario: Verify partnership establishment with municipality
    # Scenario ID: 655e595b-2367-4209-830e-5168beee82f6
    # Feature ID: 0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00
    # Scenario Type: UI
    # Description: Test the ability to establish a partnership with a municipality for route data access.
    Given the user is on the partnership establishment page
    When the user enters municipality details
    And the user clicks on the 'Establish Partnership' button
    Then a confirmation message is displayed
    And the partnership is listed in the user's partnerships
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00, scenario_id=655e595b-2367-4209-830e-5168beee82f6, type=UI

  @scenario_id:79a02f74-187c-4dca-98fb-d99bf4f59ab9
  @scenario_type:UI
  @ui_test
  Scenario: Check validation for missing municipality details
    # Scenario ID: 79a02f74-187c-4dca-98fb-d99bf4f59ab9
    # Feature ID: 0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00
    # Scenario Type: UI
    # Description: Ensure that the system validates input for municipality details before establishing a partnership.
    Given the user is on the partnership establishment page
    When the user leaves the municipality details empty
    And the user clicks on the 'Establish Partnership' button
    Then an error message is displayed indicating that details are required
    # Priority: high
    # Status: draft
    # Test Runner Info: feature_id=0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00, scenario_id=79a02f74-187c-4dca-98fb-d99bf4f59ab9, type=UI

  @scenario_id:de57f81d-3c03-47b6-9698-8a197178a8b1
  @scenario_type:UI
  @ui_test
  Scenario: Ensure partnership details are correctly reflected after establishment
    # Scenario ID: de57f81d-3c03-47b6-9698-8a197178a8b1
    # Feature ID: 0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00
    # Scenario Type: UI
    # Description: Verify that the established partnership information is accurately reflected in the user's partnership list.
    Given the user has established a partnership with a municipality
    When the user navigates to the partnerships list
    Then the partnership details are visible in the list
    And the details match the previously entered municipality details
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00, scenario_id=de57f81d-3c03-47b6-9698-8a197178a8b1, type=UI

  @scenario_id:43e167e9-f269-4946-a03f-54548e8b90dd
  @scenario_type:UI
  @ui_test
  Scenario: Test cancellation of a partnership with a municipality
    # Scenario ID: 43e167e9-f269-4946-a03f-54548e8b90dd
    # Feature ID: 0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00
    # Scenario Type: UI
    # Description: Check that the user can successfully cancel a partnership with a municipality and that it is removed from their list.
    Given the user has an existing partnership with a municipality
    When the user clicks on the 'Cancel Partnership' button
    Then a confirmation message is displayed asking for cancellation confirmation
    And upon confirmation, the partnership is removed from the list
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=0b10d679-c1c4-4e3b-ab5a-845e1ab9ed00, scenario_id=43e167e9-f269-4946-a03f-54548e8b90dd, type=UI
