@Regression
Feature: create Account feature

  @CreateAccount_1
  Scenario: create Account with /add-primary-account/
    Given url BASE_URL
    Given path "/api/accounts/add-primary-account"
    * def emailAddress = "carla.jones5@rocketmail.com"
    Given request

      """
      {
        "email": "#(emailAddress)",
        "firstName": "carla",
        "lastName": "jones",
        "title": "Mrs.",
        "gender": "Female",
        "maritalStatus": "Single",
        "employmentStatus": "unemployeed",
        "dateOfBirth": "1990-09-11 "
      }
      """
    When method post
    Then print response
    Then status 201
    Then assert response.email == emailAddress
    * def createdAccountId = response.id
    * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenGenerationResult.response.token
    Given url BASE_URL
    Given path "/api/accounts/delete-account"
    Given header Authorization = validToken
    Given param primaryPersonId = createdAccountId
    When method delete
    Then print response
    Then status 202


