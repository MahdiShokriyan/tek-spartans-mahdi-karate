Feature: API testing for Security Functions


  Background: setup steps
    Given url 'https://dev.insurance-api.tekschool-students.com'
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
    Then status 200

    @US_2
  Scenario: valid token with invalid username and valid password
    Given request
      """
      {
        "username": "wronguser",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then status 404

