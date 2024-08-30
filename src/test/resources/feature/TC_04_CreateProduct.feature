Feature: Create a new product and Get Product

  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'multipart/form-data' }
    * def result = call read('classpath:feature/TC_03_CreateCategory.feature')
    * def categoryId = result.categoryId
    * karate.log('Category ID in Background:', categoryId)

  Scenario: Create a new product and Get the product details

    # Load images as files
    * def mainImage = karate.read('classpath:images/mainImage.jpg')
    * def subImage = karate.read('classpath:images/subImage.jpg')

    # Define the request
    Given url 'https://api.freeapi.app/api/v1/ecommerce/products'
    And headers request_headers
    And multipart file mainImage = { file: mainImage, filename: 'mainImage.jpg', contentType: 'image/jpg' }
   # And multipart file subImage = { file: subImage, filename: 'subImage.jpg', contentType: 'image/jpg' }
    And multipart field category = categoryId
    And multipart field description = 'New description number 2'
    And multipart field name = 'Kids product'
    And multipart field price = '230'
    And multipart field stock = '30'
    When method post
    Then status 201

    # Verify response
    * def response = karate.response
    * print 'Response:', response
    * def productId = response.body.data._id
    * print 'Product ID after creation:', productId
    * karate.set('productId', productId)
    * print 'Category ID set globally:', karate.get('categoryId')

#GET Product Id
    * def productId = karate.get('productId')
    * karate.log('Product Id in Get Scenario:', productId)
    Given url 'https://api.freeapi.app/api/v1/ecommerce/products/' + productId
    And headers request_headers
    When method get
    Then status 200
