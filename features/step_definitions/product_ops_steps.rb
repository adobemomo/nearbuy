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

Given /the following products exist/ do |users_table|
  users_table.hashes.each do |user|
    Users.create user
  end
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

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

