Then(/^I expect Paper class to respond to "([^"]*)"$/) do |method|
  expect(Paper).to respond_to(method.to_sym)
end

Then(/^I expect Paper instance to respond to "([^"]*)"$/) do |method|
  expect(Paper.new).to respond_to(method.to_sym)
end

Given(/^(\d+) papers with the status "([^"]*)"$/) do |n, status|
  n.to_i.times {
    send("create_p_#{status}")
    expect(@paper.send("#{status}?")).to be_truthy
  }
end

Then(/^I expect (\d+) Paper "([^"]*)"$/) do |n, status|
  expect(Paper.send(status).count).to eq(n.to_i)
end

Then(/^I expect the paper status to be "([^"]*)"$/) do |status|
  expect(@paper.status).to eq(status.to_sym)
  expect(@paper.status?(status.to_sym)).to be_truthy
  expect(@paper.send("#{status}?".to_sym)).to be_truthy
end

Then(/^I expect the paper status not to be "([^"]*)"$/) do |status|
  expect(@paper.send("#{status}?".to_sym)).to be_falsy
end
