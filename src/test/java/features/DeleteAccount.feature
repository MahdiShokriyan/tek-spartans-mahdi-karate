@Regression
Feature: delete account after opening with diferenet user

  @deleteAccount_1
  Scenario Outline: create Account with /add-primary-account/
    Given url BASE_URL
    * def dataGenerator = Java.type('data.GenerateData')
    * def emailAddress = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
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
        "dateOfBirth": "1990-09-11"
      }
      """
    When method post
    Then print response
    Then status 201
    * def createdAccountId = response.id
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then status 200
    * def validToken = "Bearer " + response.token
    Given url BASE_URL
    Given path "/api/accounts/delete-account"
    Given header Authorization = validToken
    Given param primaryPersonId = createdAccountId
    When method delete
    Then print response
    Then status <statusCode>
    Examples:
      | username          | password       | statusCode |
      | operator_readonly | Tek4u2024      | 403        |
      | supervisor        | tek_supervisor | 202        |
      | mahdiyahoo        | password@123   | 403        |
