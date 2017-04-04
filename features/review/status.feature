Feature: Validate statuses work

  Scenario: Review.status
    Given 1 reviews with the status "accepted"
    And 2 reviews with the status "rejected"
    And 3 reviews with the status "cancelled"
    And 4 reviews with the status "pending"
    Then I expect 1 Review "accepted"
    Then I expect 2 Review "rejected"
    Then I expect 3 Review "cancelled"
    Then I expect 4 Review "pending"

  Scenario Outline: Review - statuses
    Given 1 reviews with the status <s1>
    Then I expect the status to be <s1>
    And I expect the status not to be <s2>
    And I expect the status not to be <s3>
    And I expect the status not to be <s4>

    Examples:
      | s1          | s2          | s3          | s4          |
      | "accepted"  | "rejected"  | "cancelled" | "pending"   |
      | "rejected"  | "cancelled" | "pending"   | "accepted"  |
      | "cancelled" | "pending"   | "accepted"  | "rejected"  |
      | "pending"   | "accepted"  | "rejected"  | "cancelled" |
