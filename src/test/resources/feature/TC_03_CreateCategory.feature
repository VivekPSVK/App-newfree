Feature: Create Category and Get Category
  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }


    Scenario: Create a new category and Get category details
      # request payload
      * def requestPayload =
      """
    { name: 'shirts' }
    """
#POST Method
      Given url 'https://api.freeapi.app/api/v1/ecommerce/categories'
      And headers request_headers
      And request requestPayload
      When method post
      Then status 201
      * def response = karate.get('response')
      * print 'Response:', response
      * def categoryId = response.data._id
      * print 'Category ID after creation:', categoryId
      * karate.set('categoryId', categoryId)
      * print 'Category ID set globally:', karate.get('categoryId')


#GET Method
        * def categoryId = karate.get('categoryId')
        * karate.log('Category ID in Get Scenario:', categoryId)
        Given url 'https://api.freeapi.app/api/v1/ecommerce/categories/' + categoryId
        And headers request_headers
        When method get
        Then status 200
      * def getResponse = karate.get('response')
      * karate.log('Category retrieved:', getResponse)
      * assert getResponse.data.name == 'shirts'

