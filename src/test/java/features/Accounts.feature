@Regression
Feature: Testing Account APIs

  Background: setup Account
    Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken
  @Account_1
  Scenario: Testing /api/accounts/get-account
    * def accountId = 9233
    Given param primaryPersonId = accountId
    When method get
    Then status 200
    Then assert response.primaryPerson.id == accountId

    @Account_2
  Scenario: Testing /api/accounts/get-account with invalid id
      * def accountId = 100
      Given param primaryPersonId = accountId
      When method get
      Then print response
      Then status 404
      Then assert response.errorMessage == "Account with id "+accountId+" not found"



