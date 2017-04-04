# Feature: Validate statuses work
#
#   Scenario: Reviewable.status
#     # Given 1 papers with the status "draft"
#     # And 2 papers with the status "rejected"
#     # And 3 papers with the status "pending_review"
#     # And 4 papers with the status "reviewed"
#     # Then I expect 1 Paper "draft"
#     # Then I expect 2 Paper "rejected"
#     # Then I expect 3 Paper "pending_review"
#     # Then I expect 4 Paper "reviewed"

  # Scenario Outline: Reviewable - statuses
  #   Given 1 reviews with the status <s1>
  #   Then I expect the status to be <s1>
  #   And I expect the status not to be <s2>
  #   And I expect the status not to be <s3>
  #   And I expect the status not to be <s4>
  #
  #   Examples:
  #     | s1          | s2          | s3          | s4          |
  #     | "accepted"  | "rejected"  | "cancelled" | "pending"   |
  #     | "rejected"  | "cancelled" | "pending"   | "accepted"  |
  #     | "cancelled" | "pending"   | "accepted"  | "rejected"  |
  #     | "pending"   | "accepted"  | "rejected"  | "cancelled" |
