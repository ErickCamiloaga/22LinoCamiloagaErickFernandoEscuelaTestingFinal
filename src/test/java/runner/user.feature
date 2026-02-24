Feature: User API Testing

  Background:
    * url baseUrl

  @user @happyPath
  Scenario: Crear usuario válido
    Given path 'user'
    And request
  """
  {
    "id": 2001,
    "username": "ericktest",
    "firstName": "Erick",
    "lastName": "QA",
    "email": "erick@test.com",
    "password": "Test123",
    "phone": "999999999",
    "userStatus": 1
  }
  """
    When method post
    Then status 200

  @user @unhappyPath
  Scenario: Login incorrecto
    Given path 'user/login'
    And param username = 'usuarioFake'
    And param password = 'malPassword'
    When method get
    Then status 400

  @user @unhappyPath
  Scenario: Login con usuario inexistente
    Given path 'user/login'
    And param username = 'usuarioFake'
    And param password = 'malPassword'
    When method get
    Then status 200
    And match response.type == 'unknown'