Feature: Validate actions work

Scenario Outline: Review - actions
  Given 1 reviews with the status <s1>
  When I <s6> the review
  Then I expect the review status to be <s2>
  And I expect the review status not to be <s3>
  And I expect the review status not to be <s4>
  And I expect the review status not to be <s5>

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
