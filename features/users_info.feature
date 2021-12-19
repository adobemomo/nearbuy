Feature: we can get the information of an user by username and retrieve his/her published goods list

  As a user, I have an unique username.
  I can also publish some goods, whose owner should be myself.

  Background: there exist some users and corresponding goods

    Given the following users exist:
      | id | email             | address | first_name | last_name | username | password | password_confirmation |
      | 1  | test@gmail.com    | nyc     | Alice      | Brown     | test     | 123456   | 123456                |
      | 2  | another@gmail.com | boston  | Bob        | Green     | another  | password | password              |

    And the following products exist:
      | name               | address                                | user_name |
      | iPhone SE2         | 166 W 107th St, New York, NY 10025     | test      |
      | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 | test      |
      | full-size mattress | 1220 5th Ave, New York, NY 10029       | another   |
      | Samsung Phone      | 1030 Amsterdam Ave, New York, NY 10025 | another   |

  Scenario: retrieve an user by username
    Given I search the user with username "test"
    Then the user should have email "test@gmail.com"
    And the user should have address "nyc"
    And the user should have first_name "Alice"
    And the user should have last_name "Brown"

  Scenario: retrieve product with specified username
    Given I search the product with username "another"
    Then the products should contain "full-size mattress,Samsung Phone"

  Scenario: explore all products near specified location
    Given explore all products near "40.80376595,-73.96178430421567"
    Given explore all products without location

