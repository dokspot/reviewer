Feature: Validate methods exist

  Scenario: review! helper methods exist
    Then I expect Review class to respond to "accepted"
    Then I expect Review class to respond to "rejected"
    Then I expect Review class to respond to "cancelled"
    Then I expect Review class to respond to "pending"
    Then I expect Review instance to respond to "accepted?"
    Then I expect Review instance to respond to "rejected?"
    Then I expect Review instance to respond to "cancelled?"
    Then I expect Review instance to respond to "pending?"
    Then I expect Review instance to respond to "status"
    Then I expect Review instance to respond to "status?"
    Then I expect Review instance to respond to "accept!"
    Then I expect Review instance to respond to "reject!"
    Then I expect Review instance to respond to "cancel!"
    Then I expect Review instance to respond to "item"
    Then I expect Review instance to respond to "user"
