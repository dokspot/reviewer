Feature: Validate methods exist

  Scenario: reviewable! helper  methods exist
    Then I expect Paper class to respond to "draft"
    Then I expect Paper class to respond to "rejected"
    Then I expect Paper class to respond to "pending_review"
    Then I expect Paper class to respond to "reviewed"
    Then I expect Paper instance to respond to "draft?"
    Then I expect Paper instance to respond to "rejected?"
    Then I expect Paper instance to respond to "pending_review?"
    Then I expect Paper instance to respond to "reviewed?"
    Then I expect Paper instance to respond to "status"
    Then I expect Paper instance to respond to "status?"
    Then I expect Paper instance to respond to "review!"
    Then I expect Paper instance to respond to "cancel!"