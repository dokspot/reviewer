Then(/^I expect Paper class to respond to "([^"]*)"$/) do |method|
  expect(Paper).to respond_to(method.to_sym)
end

Then(/^I expect Paper instance to respond to "([^"]*)"$/) do |method|
  expect(Paper.new).to respond_to(method.to_sym)
end
