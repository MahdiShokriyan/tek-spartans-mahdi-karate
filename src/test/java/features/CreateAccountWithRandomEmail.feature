@Regression
Feature: create Account feature with random generated email

  @CreateAccountWithRandom_1
  Scenario: create Account with /add-primary-account/
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
        "dateOfBirth": "1990-09-11 "
      }
      """
    When method post
    Then print response
    Then status 201
    Then assert response.email == emailAddress