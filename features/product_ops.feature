Feature: operations on product include: add, edit, delete

  As a seller
  So that I can post my product and edit or delete it then
  I want to see I can fully operate on my products

  Background: some products have been added to database

    Given the following products exist:
      | name               | address                                | update_time                     | user_name |
      | iPhone SE2         | 166 W 107th St, New York, NY 10025     | Tue, 16 Nov 2021 06:00:00 +0000 | mockUser |
      | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 | Tue, 16 Nov 2021 07:00:00 +0000 | mockUser |
      | full-size mattress | 1220 5th Ave, New York, NY 10029       | Tue, 16 Nov 2021 05:00:00 +0000 | mockUser |


    Given the following products exist:
      | email               | encrypted_password                     | created_at                      | updated_at |
      | iPhone SE2          | 166 W 107th St, New York, NY 10025     | Tue, 16 Nov 2021 06:00:00 +0000 | mockUser   |
      | Desktop table       | 55 St Nicholas Ave, New York, NY 10026 | Tue, 16 Nov 2021 07:00:00 +0000 | mockUser   |
      | full-size mattress  | 1220 5th Ave, New York, NY 10029       | Tue, 16 Nov 2021 05:00:00 +0000 | mockUser   |

    And  I am on the NearBuy home page
    Then 3 seed products should exist

  Scenario: sort by name:
    Given I am on the NearBuy home page
    Then I should see "iPhone SE2" before "Desktop table"
    Then I should see "Sort By Name"
    When I follow "Sort By Name"
    Then I should be on the NearBuy home page
    Then I should see "Desktop table" before "iPhone SE2"

  
  Scenario: sort by time:
    Given I am on the NearBuy home page
    Then I should see "iPhone SE2" before "full-size mattress"
    Then I should see "Sort By Time"
    When I follow "Sort By Time"
    Then I should be on the NearBuy home page
    Then I should see "full-size mattress" before "iPhone SE2"

  Scenario: clear sort status:
    Given I am on the NearBuy home page
    Then I should see "iPhone SE2" before "Desktop table"
    Then I should see "Sort By Name"
    When I follow "Sort By Name"
    Then I should be on the NearBuy home page
    Then I should see "Desktop table" before "iPhone SE2"
    Then I should see "Clear Sort Status"
    When I follow "Clear Sort Status"
    Then I should be on the NearBuy home page
    Then I should see "iPhone SE2" before "Desktop table"
  
    
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

  Scenario: Sign Up&Sign In User and profile
    Given I am on the NearBuy home page
    When I follow "Sign Up"
    Then I should be on the Sign Up page
    When I fill in "user_email" with "testUser@gmail.com"
    And I fill in "user_password" with "123456"
    And I fill in "user_password_confirmation" with "123456"
    And I fill in "user_username" with "testUser"
    And I press "Sign up"
    Then I should be on the logged in page
    And I should see "Sign Out"
    When I follow "Profile"
    Then I should be on the profile page for "testUser"
    And I should see "testuser@gmail.com"
    And I should see "testUser"
    And I follow "Back"
    Then I follow "Sign Out"
    When I follow "Sign In"
    Then I should be on the Sign In Page
    And I fill in "user_email" with "testUser@gmail.com"
    And I fill in "user_password" with "123456"
    And I press "Log in"
    Then I should be on the logged in page
    And I should see "Sign Out"


  

    
