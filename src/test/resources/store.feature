Feature: Store API Testing

  Background:
    * url baseUrl

  @store-1 @happyPath
  Scenario: Crear orden válida
    Given path 'store/order'
    And request { id: 1001, petId: 10, quantity: 1, shipDate: "2025-02-25T10:00:00.000Z", status: "placed", complete: true }
    When method post
    Then status 200
    And match response.id == 1001

  @store-2 @unhappyPath
  Scenario: Consultar orden inexistente
    Given path 'store/order/99999999'
    When method get
    Then status 404