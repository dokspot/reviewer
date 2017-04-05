Feature: Validate states work

  Scenario: Verify all states are present
    Then I expect Review class to have the state "pending"
    Then I expect Review class to have the state "rejected"
    Then I expect Review class to have the state "accepted"
    Then I expect Review class to have the state "cancelled"
    Then I expect Review class not to have the state "draft"
    Then I expect Review class not to have the state "published"
    Then I expect Review class not to have the state "retired"

  Scenario: Review.state
    Given 1 reviews with the state "accepted"
    And 2 reviews with the state "rejected"
    And 3 reviews with the state "cancelled"
    And 4 reviews with the state "pending"
    Then I expect 1 Review "accepted"
    Then I expect 2 Review "rejected"
    Then I expect 3 Review "cancelled"
    Then I expect 4 Review "pending"

  Scenario Outline: Review - statees
    Given 1 reviews with the state <s1>
    Then I expect the review state to be <s1>
    And I expect the review state not to be <s2>
    And I expect the review state not to be <s3>
    And I expect the review state not to be <s4>

    Examples:
      | s1          | s2          | s3          | s4          |
      | "accepted"  | "rejected"  | "cancelled" | "pending"   |
      | "rejected"  | "cancelled" | "pending"   | "accepted"  |
      | "cancelled" | "pending"   | "accepted"  | "rejected"  |
      | "pending"   | "accepted"  | "rejected"  | "cancelled" |
