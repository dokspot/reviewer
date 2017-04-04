Then(/^I expect Paper class to respond to "([^"]*)"$/) do |method|
  expect(Paper).to respond_to(method.to_sym)
end

Then(/^I expect Paper instance to respond to "([^"]*)"$/) do |method|
  expect(Paper.new).to respond_to(method.to_sym)
end

Given(/^(\d+) papers with the status "([^"]*)"$/) do |n, status|
  n.to_i.times {
    send("create_p_#{status}")
  }
end

Then(/^I expect (\d+) Paper "([^"]*)"$/) do |n, status|
  expect(Paper.send(status).count).to eq(n.to_i)
end
