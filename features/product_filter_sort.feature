Feature: show products with sorting and filtering

    As a buyer
    So that I can search and filter the goods I need

    Background: some products have been added to database

        Given the following products exist:
            | name               | address                                | user_name | update_time |
            | iPhone SE2         | 166 W 107th St, New York, NY 10025     | test      | 2001-01-01  |
            | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 | test      | 2000-01-01  |
            | full-size mattress | 1220 5th Ave, New York, NY 10029       | test      | 1998-01-01  |
            | Samsung Phone      | 1030 Amsterdam Ave, New York, NY 10025 | test      | 2049-01-01  |
        And the following users exist:
            | id | email          | address | first_name | last_name | username | password | password_confirmation |
            | 1  | test@gmail.com | nyc     | Alice      | Brown     | test     | 123456   | 123456                |

        And  I am on the NearBuy home page
        Then 4 seed products should exist

    Scenario: sort by name:
        Given I am on the NearBuy home page
        Then I should see "iPhone SE2" before "Desktop table"
        Then I should see "Goods Name"
        When I follow "Goods Name"
        Then I should be on the NearBuy home page
        Then I should see "Desktop table" before "iPhone SE2"


    Scenario: sort by time:
        Given I am on the NearBuy home page
        Then I should see "iPhone SE2" before "full-size mattress"
        Then I should see "Update Time"
        When I follow "Update Time"
        Then I should be on the NearBuy home page
        Then I should see "full-size mattress" before "iPhone SE2"

    Scenario: clear sort status:
        Given I am on the NearBuy home page
        Then I should see "iPhone SE2" before "Desktop table"
        Then I should see "Goods Name"
        When I follow "Goods Name"
        Then I should be on the NearBuy home page
        Then I should see "Desktop table" before "iPhone SE2"
        Then I should see "Clear Sort Status"
        When I follow "Clear Sort Status"
        Then I should be on the NearBuy home page
        Then I should see "iPhone SE2" before "Desktop table"