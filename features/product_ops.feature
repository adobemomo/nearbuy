Feature: operations on product include: add, edit, delete

  As a seller
  So that I can post my product and edit or delete it then
  I want to see I can fully operate on my products

  Background: some products have been added to database

    Given the following products exist:
      | name               | address                                |
      | iPhone SE2         | 166 W 107th St, New York, NY 10025     |
      | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 |
      | full-size mattress | 1220 5th Ave, New York, NY 10029       |

    And  I am on the NearBuy home page
    Then 3 seed products should exist

  Scenario: add a new product
    Given I am on the NearBuy home page
    Then I should see "Add new goods"
    When I follow "Add new goods"
    Then I should be on the create new product page
    When I fill in "Name" with "Samsung S21U 128G"
    And I fill in "Address" with "2880 Broadway, New York, NY 10025"
    And I press "GO"
    Then I should be on the NearBuy home page
    And I should see "Samsung S21U 128G" on the products list

  Scenario: edit an exist product
    Given I am on the NearBuy home page
    When I press op button "edit" under "iPhone SE2"
    Then I should be on the edit product page for "iPhone SE2"
    When I fill in "Name" with "iPhone SE2 256G"
    And I press "GO"
    Then I should be on the detail page for "iPhone SE2 256G"
    And I should see "iPhone SE2 256G" on the products list

  Scenario: delete an exist product
    Given I am on the NearBuy home page
    When I press op button "delete" under "Desktop table"
    Then I should be on the delete page for "Desktop table"
    When I follow "delete"
    Then I should be on the NearBuy home page
    And I should not see "Desktop table"
