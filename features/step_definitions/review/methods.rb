Then(/^I expect Review class to respond to "([^"]*)"$/) do |method|
  expect(Review).to respond_to(method.to_sym)
end

Then(/^I expect Review instance to respond to "([^"]*)"$/) do |method|
  expect(Review.new).to respond_to(method.to_sym)
end

Given(/^(\d+) reviews with the state "([^"]*)"$/) do |n, state|
  n.to_i.times {
    send("create_r_#{state}")
  }
end

Then(/^I expect (\d+) Review "([^"]*)"$/) do |n, state|
  expect(Review.send(state).count).to eq(n.to_i)
end

Then(/^I expect the review state to be "([^"]*)"$/) do |state|
  expect(@review.state).to eq(state.to_sym)
  expect(@review.state?(state.to_sym)).to be_truthy
  expect(@review.send("#{state}?".to_sym)).to be_truthy
end

Then(/^I expect the review state not to be "([^"]*)"$/) do |state|
  expect(@review.send("#{state}?".to_sym)).to be_falsy
end


When(/^I "([^"]*)" the review$/) do |action|
  @review.send(action.to_sym)
end

Then(/^I expect Review class to have the state "([^"]*)"$/) do |state|
  expect(Review.states).to include(state.to_sym)
end

Then(/^I expect Review class not to have the state "([^"]*)"$/) do |state|
  expect(Review.states).not_to include(state.to_sym)
end
