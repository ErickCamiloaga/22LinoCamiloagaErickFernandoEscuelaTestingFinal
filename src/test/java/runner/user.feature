Feature: User API Testing

  Background:
    * url baseUrl
    * def testUser =
    """
    {
      "id": 3001,
      "username": "test123",
      "firstName": "ttt321",
      "lastName": "QA1234",
      "email": "tttpro12@test.com",
      "password": "Test123",
      "phone": "987654321",
      "userStatus": 1
    }
    """

  @user-happy-1 @user @happyPath
  Scenario: Crear usuario válido
    Given path 'user'
    And request testUser
    When method post
    Then status 200
    And match response.code == 200

  @user-happy-2 @user @happyPath
  Scenario: Obtener usuario existente
    Given path 'user', testUser.username
    When method get
    Then status 200
    And match response.username == testUser.username
    And match response.email == testUser.email

  @user-happy-3 @user @happyPath
  Scenario: Login correcto
    Given path 'user/login'
    And param username = testUser.username
    And param password = testUser.password
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  @user-happy-4  @user @happyPath
  Scenario: Logout correcto
    Given path 'user/logout'
    When method get
    Then status 200

  @user-happy-5 @user @happyPath
  Scenario: Eliminar usuario existente
    Given path 'user', testUser.username
    When method delete
    Then status 200

    Given path 'user', testUser.username
    When method get
    Then status 404

  @user-unhappy-1 @user @unhappyPath
  Scenario: Obtener usuario inexistente
    Given path 'user', 'usuarioQueNoExiste123'
    When method get
    Then status 404

  @user-unhappy-2 @user @unhappyPath
  Scenario: Login con password incorrecto
    Given path 'user/login'
    And param username = testUser.username
    And param password = 'passwordIncorrecto'
    When method get
    Then status 200
    And match response.type == 'unknown'

  @user-unhappy-3 @user @unhappyPath
  Scenario: Login con usuario inexistente
    Given path 'user/login'
    And param username = 'fakeUser999'
    And param password = '123456'
    When method get
    Then status 200
    And match response.type == 'unknown'

  @user-unhappy-4 @user @unhappyPath
  Scenario: Eliminar usuario inexistente
    Given path 'user', 'fakeUserToDelete'
    When method delete
    Then status 404

  @user-unhappy-5 @user @unhappyPath
  Scenario: Crear usuario duplicado
    Given path 'user'
    And request testUser
    When method post
    Then status 200

  @user-unhappy-6 @user @unhappyPath
  Scenario: Crear usuario con campos faltantes
    Given path 'user'
    And request { id: 4001 }
    When method post
    Then status 200

  @user-unhappy-7 @user @unhappyPath
  Scenario: Crear usuario con id tipo string
    Given path 'user'
    And request
    """
    {
      "id": "texto",
      "username": "errorTipo",
      "firstName": "Test"
    }
    """
    When method post
    Then status 500

  @user-unhappy-8 @user @unhappyPath
  Scenario: Crear usuario con username muy largo
    * def longUsername = 'a'.repeat(150)
    Given path 'user'
    And request
    """
    {
      "id": 5001,
      "username": #(longUsernameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee)
    }
    """
    When method post
    Then status 200