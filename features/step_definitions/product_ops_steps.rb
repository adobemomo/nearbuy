def find_edit_btn_for_product(product_name)
  find(:xpath, "//a[contains(.,'#{product_name}')]/ancestor::h2/following-sibling::p/following-sibling::a[1]")
end

def find_delete_btn_for_product(product_name)
  find(:xpath, "//a[contains(.,'#{product_name}')]/ancestor::h2/following-sibling::p/following-sibling::a[2]")
end


Given /the following products exist/ do |products_table|
  products_table.hashes.each do |product|
    Goods.create product
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Then /I should see "(.*)" before "(.*)"/ do |a, b|
 regexp = /^.*#{a}.*#{b}.*$/
  expect(page.body).to match(regexp)
end

Then /I should see "(.*)" on the products list/ do |product_name|
  ## FIXME use list selector
  expect(page).to have_content(/#{product_name}/)
end

Then /I press op button "(.*)" under "(.*)"/ do |op, product_name|
  ## TODO get button and click
  if op == "edit"
    find_edit_btn_for_product(product_name).click
  else
    find_delete_btn_for_product(product_name).click
  end
end

Then(/^(\d+) seed products should exist$/) do |arg|
  Goods.count.should be arg.to_i
end

When /I wait/ do 
  sleep(10)
end