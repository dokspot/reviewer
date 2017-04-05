Then(/^I expect Paper class to respond to "([^"]*)"$/) do |method|
  expect(Paper).to respond_to(method.to_sym)
end

Then(/^I expect Paper instance to respond to "([^"]*)"$/) do |method|
  expect(Paper.new).to respond_to(method.to_sym)
end

Given(/^(\d+) papers with the state "([^"]*)"$/) do |n, state|
  n.to_i.times {
    send("create_p_#{state}")
    expect(@paper.send("#{state}?")).to be_truthy
  }
end

Then(/^I expect (\d+) Paper "([^"]*)"$/) do |n, state|
  expect(Paper.send(state).count).to eq(n.to_i)
end

Then(/^I expect the paper state to be "([^"]*)"$/) do |state|
  expect(@paper.state).to eq(state.to_sym)
  expect(@paper.state?(state.to_sym)).to be_truthy
  expect(@paper.send("#{state}?".to_sym)).to be_truthy
end

Then(/^I expect the paper state not to be "([^"]*)"$/) do |state|
  expect(@paper.send("#{state}?".to_sym)).to be_falsy
end

When(/^I "([^"]*)" the paper$/) do |action|
  @paper.send(action.to_sym)
end

Then(/^I expect Paper class to have the state "([^"]*)"$/) do |state|
  expect(Paper.states).to include(state.to_sym)
end

Then(/^I expect Paper class not to have the state "([^"]*)"$/) do |state|
  expect(Paper.states).to_not include(state.to_sym)
end
