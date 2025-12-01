@feature_id:e5e3af29-baa2-4634-9079-82f1cb9b9134
@epic_id:d3d67381-e966-4546-882a-8715ca687cb1
Feature: Real-time Rider and Driver Matching
  Automatically match riders with drivers based on proximity and destination.

  @scenario_id:d25c5e8b-7c49-4a5f-828a-120c407ac33e
  @scenario_type:API
  @api_test
  Scenario: Match Rider with Nearby Driver
    # Scenario ID: d25c5e8b-7c49-4a5f-828a-120c407ac33e
    # Feature ID: e5e3af29-baa2-4634-9079-82f1cb9b9134
    # Scenario Type: API
    # Description: Test the system's ability to match a rider with the nearest driver based on proximity.
    Given a rider opens the app and requests a ride
    When the system identifies nearby drivers
    Then the rider is matched with the closest driver
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e5e3af29-baa2-4634-9079-82f1cb9b9134, scenario_id=d25c5e8b-7c49-4a5f-828a-120c407ac33e, type=API

  @scenario_id:54eb9453-59ad-45b9-87b2-35da58ca7684
  @scenario_type:API
  @api_test
  Scenario: Match Rider with Driver Heading to Same Destination
    # Scenario ID: 54eb9453-59ad-45b9-87b2-35da58ca7684
    # Feature ID: e5e3af29-baa2-4634-9079-82f1cb9b9134
    # Scenario Type: API
    # Description: Ensure riders are matched with drivers going to similar destinations, even if they are not the nearest.
    Given a rider requests a ride to a specific destination
    When the system checks available drivers heading to the same destination
    Then the rider is matched with a driver heading to the same destination
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e5e3af29-baa2-4634-9079-82f1cb9b9134, scenario_id=54eb9453-59ad-45b9-87b2-35da58ca7684, type=API

  @scenario_id:8ee1a748-b462-4fe6-96bd-6d10db9ec40c
  @scenario_type:API
  @api_test
  Scenario: Update Driver Location and Re-match Rider
    # Scenario ID: 8ee1a748-b462-4fe6-96bd-6d10db9ec40c
    # Feature ID: e5e3af29-baa2-4634-9079-82f1cb9b9134
    # Scenario Type: API
    # Description: Test how the system re-matches riders when a driver changes their location.
    Given a rider is matched with a driver
    When the driver changes their location
    Then the system re-evaluates and matches the rider with a new driver if necessary
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e5e3af29-baa2-4634-9079-82f1cb9b9134, scenario_id=8ee1a748-b462-4fe6-96bd-6d10db9ec40c, type=API

  @scenario_id:4f5b9fa4-ad14-4e68-b6c9-f74165093ef3
  @scenario_type:API
  @api_test
  Scenario: Handle Multiple Riders Requesting Same Driver
    # Scenario ID: 4f5b9fa4-ad14-4e68-b6c9-f74165093ef3
    # Feature ID: e5e3af29-baa2-4634-9079-82f1cb9b9134
    # Scenario Type: API
    # Description: Test how the system handles multiple riders requesting the same driver at the same time.
    Given multiple riders request a ride to similar destinations
    When the system identifies a single driver available for all requests
    Then the system assigns the driver to one of the riders based on proximity and timing
    # Priority: medium
    # Status: draft
    # Test Runner Info: feature_id=e5e3af29-baa2-4634-9079-82f1cb9b9134, scenario_id=4f5b9fa4-ad14-4e68-b6c9-f74165093ef3, type=API
