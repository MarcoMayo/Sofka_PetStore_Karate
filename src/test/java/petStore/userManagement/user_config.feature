@PetStore
Feature: User Pet Store

  Background:
    * url api.baseurl
    * def dataFaker = Java.type('com.github.javafaker.Faker')
    * def objectDataFaker = new dataFaker()

  @Create
  Scenario: Create user
    * def payload = read('classpath:../data/createUser/new_user.json')
    * set payload.username = objectDataFaker.name().firstName() + objectDataFaker.number().randomDigit()
    * set payload.firstName = objectDataFaker.name().firstName()
    * set payload.email = objectDataFaker.name().username() + '@mail.com'
    Given path 'user'
    And request payload
    When method POST
    Then status 200

  @GetUserName
  Scenario: Get user by username
    Given def createUser = call read('user_config.feature@Create')
    When path 'user/' + createUser.payload.username
    And method GET
    Then status 200
    And match response.firstName == createUser.payload.firstName
    And match response.email == createUser.payload.email

  @UpdateEmail
  Scenario: Update mail and name
    Given def createUser = call read('user_config.feature@Create')
    * def payloadUpdate = createUser.payload
    * set payloadUpdate.email = 'correoUpdate@mail.com'
    * set payloadUpdate.firstName = 'nameUpdate'
    Given path 'user/' + createUser.payload.username
    And request payloadUpdate
    When method PUT
    Then status 200

  @GetUserNameUpdate
  Scenario: Get user by username
    Given def updateUser = call read('user_config.feature@UpdateEmail')
    * print updateUser
    And path 'user/' + updateUser.createUser.payload.username
    When method GET
    Then status 200
    And match response.firstName == "nameUpdate"
    And match response.email == "correoUpdate@mail.com"

  @DeleteUserName
  Scenario: Delete user by username
    Given def createUser = call read('user_config.feature@Create')
    When path 'user/' + createUser.payload.username
    And method DELETE
    Then status 200






