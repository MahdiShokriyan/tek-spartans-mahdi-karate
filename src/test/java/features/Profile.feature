@Regression
Feature: get account info

  @profile_1
  Scenario Outline: get information of readOnly account
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "operator_readonly",
        "password": "Tek4u2024"
      }
      """
    When method post
    * def validToken = response.token
    Given url BASE_URL
    Given path "/api/user/profile"
    Given header Authorization = "Bearer " + validToken
    When method get
    Then print response
    Then status 200
    Examples:
      | username          | password       |
      | operator_readonly | Tek4u2024      |
      | supervisor        | tek_supervisor |