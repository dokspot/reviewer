Feature: Validate statuses work

  Scenario: Reviewable.status
    Given 1 papers with the status "draft"
    And 1 papers with the status "rejected"
    And 1 papers with the status "pending_review"
    And 1 papers with the status "reviewed"
    Then I expect 1 Paper "draft"
    Then I expect 1 Paper "rejected"
    Then I expect 1 Paper "pending_review"
    Then I expect 1 Paper "reviewed"

  Scenario Outline: Reviewable - statuses
    Given 1 papers with the status <s1>
    Then I expect the paper status to be <s1>
    And I expect the paper status not to be <s2>
    And I expect the paper status not to be <s3>
    And I expect the paper status not to be <s4>

    Examples:
      | s1                | s2                | s3                | s4                |
      | "draft"           | "rejected"        | "pending_review"  | "reviewed"        |
      | "rejected"        | "pending_review"  | "reviewed"        | "draft"           |
      | "pending_review"  | "reviewed"        | "draft"           | "rejected"        |
      | "reviewed"        | "draft"           | "rejected"        | "pending_review"  |
