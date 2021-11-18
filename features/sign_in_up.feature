Feature: user can create account and log in to manage goods

    As a user who want to sell my goods
    So that I can post my product and edit or delete it then
    I want to see I can fully operate on my products

    Background: some products have been added to database

        Given the following products exist:
            | name               | address                                |
            | iPhone SE2         | 166 W 107th St, New York, NY 10025     |
            | Desktop table      | 55 St Nicholas Ave, New York, NY 10026 |
            | full-size mattress | 1220 5th Ave, New York, NY 10029       |
            | Samsung Phone      | 1030 Amsterdam Ave, New York, NY 10025 |


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

    Scenario: Sign In with Wrong Password
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
        When I follow "Sign Out"
        When I follow "Sign In"
        Then I should be on the Sign In Page
        And I fill in "user_email" with "testUser@gmail.com"
        And I fill in "user_password" with "654321"
        Then I should be on the Sign In Page


    Scenario: Sign In with Wrong Format Email
        Given I am on the NearBuy home page
        When I follow "Sign In"
        Then I should be on the Sign In Page
        And I fill in "user_email" with "testUser"
        And I fill in "user_password" with "654321"
        Then I should be on the Sign In Page