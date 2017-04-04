Then(/^I expect Review class to respond to "([^"]*)"$/) do |method|
  expect(Review).to respond_to(method.to_sym)
end

Then(/^I expect Review instance to respond to "([^"]*)"$/) do |method|
  expect(Review.new).to respond_to(method.to_sym)
end

Given(/^(\d+) reviews with the status "([^"]*)"$/) do |n, status|
  n.to_i.times {
    send("create_r_#{status}")
  }
end

Then(/^I expect (\d+) Review "([^"]*)"$/) do |n, status|
  expect(Review.send(status).count).to eq(n.to_i)
end

Then(/^I expect the status to be "([^"]*)"$/) do |status|
  expect(@review.status).to eq(status.to_sym)
  expect(@review.status?(status.to_sym)).to be_truthy
  expect(@review.send("#{status}?".to_sym)).to be_truthy
end

Then(/^I expect the status not to be "([^"]*)"$/) do |status|
  expect(@review.send("#{status}?".to_sym)).to be_falsy
end


When(/^I "([^"]*)" the review$/) do |action|
  @review.send(action.to_sym)
end
