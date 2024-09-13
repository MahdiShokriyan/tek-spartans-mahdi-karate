Feature: Testing adding car and phone to an account


  Background: Setup test
  Given url BASE_URL
    * def createAccountResult = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccountResult.response.id
    * def tokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token
@AccountCarAndPhone_1
  Scenario: Testing Adding phone
  Given path "/api/accounts/add-account-phone/"
    Given param primaryPersonId = newAccountId
    Given header Authorization = validToken
    Given request
    """
    {
      "phoneNumber": "1234567819",
      "phoneExtension": "",
      "phoneTime": "Anytime",
      "phoneType": "Mobile"
    }
    """
    When method post
    Then print response
    Then status 201
    And assert response.phoneNumber == "1234567819"

   @AccountCarAndPhone_2
  Scenario:Testing Adding car
    Given path "/api/accounts/add-account-car/"
    Given param primaryPersonId = newAccountId
    Given header Authorization = validToken
    Given request
      """
      {
        "make": "BMW",
        "model": "i5",
        "year": "2024",
        "licensePlate": "virginia12"
      }
      """
    When method post
    Then print response
    Then status 201
    And assert response.make == "BMW"