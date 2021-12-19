Given /I search the user with username "([^"]*)"/ do |username|
  @user = User.get_user_by_username(username)
end

Then /the user should have email "([^"]*)"$/ do |email|
  expect(@user.email).to eq email
end

Then /the user should have address "([^"]*)"$/ do |address|
  expect(@user.address).to eq address
end

Then /the user should have first_name "([^"]*)"$/ do |first_name|
  expect(@user.first_name).to eq first_name
end

Then /the user should have last_name "([^"]*)"$/ do |last_name|
  expect(@user.last_name).to eq last_name
end

Given /I search the product with username "([^"]*)"$/ do |username|
  @good = User.get_goods_of_user(username)
end

Then /the products should contains "([^"]*)"$/ do |goods_list|
  puts goods_list
end