Feature: Validate methods work

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

  Scenario Outline: Review - actions
    Given 1 reviews with the status <s1>
    When I <s6> the review
    Then I expect the status to be <s2>
    And I expect the status not to be <s3>
    And I expect the status not to be <s4>
    And I expect the status not to be <s5>

    Examples:
      | s1          | s2          | s3          | s4          | s5          | s6        |
      | "accepted"  | "accepted"  | "rejected"  | "cancelled" | "pending"   | "accept!" |
      | "rejected"  | "accepted"  | "rejected"  | "cancelled" | "pending"   | "accept!" |
      | "cancelled" | "cancelled" | "rejected"  | "accepted"  | "pending"   | "accept!" |
      | "pending"   | "accepted"  | "rejected"  | "cancelled" | "pending"   | "accept!" |
      | "accepted"  | "rejected"  | "accepted"  | "cancelled" | "pending"   | "reject!" |
      | "rejected"  | "rejected"  | "accepted"  | "cancelled" | "pending"   | "reject!" |
      | "cancelled" | "cancelled" | "rejected"  | "accepted"  | "pending"   | "reject!" |
      | "pending"   | "rejected"  | "accepted"  | "cancelled" | "pending"   | "reject!" |
      | "accepted"  | "cancelled" | "accepted"  | "rejected"  | "pending"   | "cancel!" |
      | "rejected"  | "cancelled" | "accepted"  | "rejected"  | "pending"   | "cancel!" |
      | "cancelled" | "cancelled" | "accepted"  | "rejected"  | "pending"   | "cancel!" |
      | "pending"   | "cancelled" | "accepted"  | "rejected"  | "pending"   | "cancel!" |
