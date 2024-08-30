Feature: Get available products
  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }

  Scenario: Fetch available products and get specific product
    Given url 'https://api.freeapi.app/api/v1/ecommerce/products?page=1&limit=10'
    And headers request_headers
    When method get
    Then status 200
    * def responseData = response.data
    Then print 'Response Data :', responseData

    * def filterProductIds =
      """
      function(arg){
        for (let i = 0; i < arg.length; i++){
          if (arg[i]._id === "66cefbe3b474b0093e8ee184"){
            return arg[i];
          }
        }
        return null;
      }
      """

    * def product = call filterProductIds responseData.products
    Then print 'Filtered Product :', product