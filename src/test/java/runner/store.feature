Feature: Store API Testing - Orden dinamica

  Background:
    * url baseUrl
    * def orderId = Math.floor(Math.random() * 1000000)

  @store-happy-1 @store @happyPath
  Scenario: Crear orden válida con id dinámico
    Given path 'store/order'
    And request
      """
      {
        "id": #(orderId),
        "petId": 10,
        "quantity": 2,
        "shipDate": "2026-02-25T10:00:00.000Z",
        "status": "placed",
        "complete": true
      }
      """
    When method post
    Then status 200
    And assert responseTime < 2000
    And match response.id == orderId
    And match response.status == "placed"
    And match response.complete == true
    And match response.id == '#number'
    And match response.status == '#string'

  @store-happy-2 @store @happyPath
  Scenario: Consultar orden creada
    Given path 'store/order', orderId
    When method get
    Then status 200
    And assert responseTime < 2000
    And match response.id == orderId
    And match response.status == "placed"

  @store-happy-3 @store @happyPath
  Scenario: Eliminar orden creada
    Given path 'store/order', orderId
    When method delete
    Then status 200
    And assert responseTime < 2000

  @store-unhappy-1 @store @unhappyPath
  Scenario: Consultar orden inexistente
    Given path 'store/order', 999999999
    When method get
    Then status 404
    And assert responseTime < 2000

  @store-unhappy-2 @store @unhappyPath
  Scenario: Crear orden con cantidad negativa
    Given path 'store/order'
    And request
      """
      {
        "id": -1,
        "petId": 10,
        "quantity": -5,
        "shipDate": "2026-02-25T10:00:00.000Z",
        "status": "placed",
        "complete": true
      }
      """
    When method post
    Then status 200
    And assert responseTime < 2000

  @store-flow @store @happyPath
  Scenario: Flujo completo de orden
    # Crear orden
    Given path 'store/order'
    And request
      """
      {
        "id": #(orderId),
        "petId": 10,
        "quantity": 1,
        "shipDate": "2026-02-25T10:00:00.000Z",
        "status": "placed",
        "complete": true
      }
      """
    When method post
    Then status 200
    And assert responseTime < 2000
    And match response.id == orderId

    # Consultar orden creada
    Given path 'store/order', orderId
    When method get
    Then status 200
    And match response.id == orderId

    # Eliminar orden
    Given path 'store/order', orderId
    When method delete
    Then status 200

    # Validar que ya no exista
    Given path 'store/order', orderId
    When method get
    Then status 404

  @store-unhappy-flow @store @unhappyPath
  Scenario: Flujo negativo - Crear orden inválida y validar comportamiento

    # Intentar crear orden con datos inválidos
    Given path 'store/order'
    And request
      """
      {
        "id": #(invalidOrderId),
        "petId": 10,
        "quantity": -5,
        "shipDate": "fecha-invalida",
        "status": "placed",
        "complete": true
      }
      """
    When method post
    Then status 200
    And assert responseTime < 2000

    # Verificar si realmente fue creada (análisis crítico)
    Given path 'store/order', invalidOrderId
    When method get
    Then match [200,404] contains responseStatus
    And print "Observación: La API permite crear orden con datos inválidos"