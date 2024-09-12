@Regression
Feature: get all account
  @gaAccount_1
  Scenario: get all account without authentication
    Given url BASE_URL
    Given path "api/accounts/get-all-accounts"
    When method get
    Then print response
    Then status 401
  @gaAccount_2
  Scenario: get all account with authentication
    Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "api/accounts/get-all-accounts"
    Given header Authorization = validToken
    When method get
    Then print response
    Then status 200
    * def generateValidToken = callonce read('Generate')



