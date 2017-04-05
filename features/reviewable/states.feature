Feature: Validate statees work

  Scenario: Verify all states are present
    Then I expect Paper class to have the state "draft"
    Then I expect Paper class to have the state "rejected"
    Then I expect Paper class to have the state "reviewed"
    Then I expect Paper class to have the state "pending"
    Then I expect Paper class not to have the state "retired"
    Then I expect Paper class not to have the state "accepted"
    Then I expect Paper class not to have the state "cancelled"

  Scenario: Reviewable.state
    Given 1 papers with the state "draft"
    And 2 papers with the state "rejected"
    And 3 papers with the state "pending"
    And 4 papers with the state "reviewed"
    Then I expect 1 Paper "draft"
    Then I expect 2 Paper "rejected"
    Then I expect 3 Paper "pending"
    Then I expect 4 Paper "reviewed"

  Scenario Outline: Reviewable - statees
    Given 1 papers with the state <s1>
    Then I expect the paper state to be <s1>
    And I expect the paper state not to be <s2>
    And I expect the paper state not to be <s3>
    And I expect the paper state not to be <s4>

    Examples:
      | s1          | s2          | s3          | s4          |
      | "draft"     | "rejected"  | "pending"   | "reviewed"  |
      | "rejected"  | "pending"   | "reviewed"  | "draft"     |
      | "pending"   | "reviewed"  | "draft"     | "rejected"  |
      | "reviewed"  | "draft"     | "rejected"  | "pending"   |
