@Regression
Feature: create and delete account
  @CreateAndDelete_1
  Scenario: Create Account and then Delete it
    Given url BASE_URL
    * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
    * def tokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/get-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = validToken
    When method get
    Then print response
    Then status 200
    Then assert response.primaryPerson.email == createAccount.response.email
    Then assert response.primaryPerson.firstName == createAccount.response.firstName
    Then assert response.primaryPerson.gender == createAccount.response.gender
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = validToken
    When method delete
    Then print response
    Then status 202
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = validToken
    When method delete
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id "+newAccountId+" not exist"