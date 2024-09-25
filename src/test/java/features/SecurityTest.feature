@Regression
Feature: API testing for Security Functions


  Background: setup steps
    Given url BASE_URL
    Given path '/api/token'
  @US_1
  Scenario: Valid token with valid credentials
    Given request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then print response
    Then status 200
    Then assert response.username == "supervisor"

  @US_2
  Scenario Outline: valid token with invalid username and valid password
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.errorMessage == "<errorMessage>"
    Examples:
      | username   | password       | statusCode | errorMessage             |
      | wronguser  | tek_supervisor | 404        | User wronguser not found |
      | supervisor | wrongpassword  | 400        | Password not matched     |
      | wronguser  | wrongpassword  | 404        | User wronguser not found |