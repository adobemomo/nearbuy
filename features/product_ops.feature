Feature: operations on product include: add, edit, delete

  As a seller
  So that I can post my product and edit or delete it then
  I want to see I can fully operate on my products

  Background: some products have been added to database

    Given the following products exist:
      | name               | address                                | user_name |
      | iPhone SE2         | 166 W 107th St, New York, NY 10025     | test      |
      | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 | test      |
      | full-size mattress | 1220 5th Ave, New York, NY 10029       | test      |
      | Samsung Phone      | 1030 Amsterdam Ave, New York, NY 10025 | test      |
    And the following users exist:
      | id | email          | address | first_name | last_name | username | password | password_confirmation |
      | 1  | test@gmail.com | nyc     | Alice      | Brown     | test     | 123456   | 123456                |

    And  I am on the NearBuy home page
    When I follow "Sign In"
    Then I should be on the Sign In Page
    And I fill in "user_email" with "test@gmail.com"
    And I fill in "user_password" with "123456"
    And I press "Log in"
    Then 4 seed products should exist
    And I should be on the logged in page

  Scenario: add a new product
    Given I am on the Goods List page
    Then I should see "Add new goods"
    When I follow "Add new goods"
    Then I should be on the create new product page
    When I fill in "Name" with "Samsung S21U 128G"
    And I fill in "Address" with "2880 Broadway, New York, NY 10025"
    And I press "GO"
    Then I should be on the Goods List page
    And I should see "Samsung S21U 128G" on the products list

  Scenario: edit an exist product
    Given I am on the Goods List page
    When I press op button "edit" under "iPhone SE2"
    Then I should be on the edit product page for "iPhone SE2"
    When I fill in "Name" with "iPhone SE2 256G"
    And I press "GO"
    Then I should be on the Goods List page
    And I should see "iPhone SE2 256G" on the products list

  Scenario: delete an exist product
    Given I am on the Goods List page
    When I press op button "delete" under "Desktop table"
    Then I should be on the Goods List page
    And I should not see "Desktop table"
