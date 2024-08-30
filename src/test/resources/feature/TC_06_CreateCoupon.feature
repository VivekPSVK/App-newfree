Feature: Create a new coupon

  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }
    * def random =
  """
  function() {
  return Math.random().toString(36).substring(2, 8);
  }
  """
    * def uniqueId = random()
    * def couponCode = 'GET' + uniqueId


  Scenario: Create a coupon with details

    # Define the request body
    * def requestPayload3 =
 """
    {
      "name": "Season sale",
      "couponCode": "#(couponCode)",
      "type": "FLAT",
      "discountValue": 605,
      "minimumCartValue": 700,
      "expiryDate": "2024-12-13T11:07:10.693Z",
      "startDate": "2023-02-13T11:07:10.693Z"
  }
    """


    # Send the POST request
    Given url 'https://api.freeapi.app/api/v1/ecommerce/coupons'
    And headers request_headers
    And request requestPayload3
    When method post
    Then status 201
    * print response

     # Verify response
    * def response = karate.response
    * print 'Response:', response
    * def couponId = response.body.data._id
    * print 'Coupon ID after creation:', couponId
    * karate.set('couponId', couponId)
    * print 'Coupon ID set globally:', karate.get('couponId')
    # Validate response body
    * assert response.body.data.name == 'Season sale'

# GET Coupon Id
    * def couponId = karate.get('couponId')
    * karate.log('CouponId ID in Get Scenario:', couponId)
    Given url 'https://api.freeapi.app/api/v1/ecommerce/coupons/' + couponId
    And headers request_headers
    When method get
    Then status 200
    * print response
    * def couponresponseJson = response

    * def writeToFile =
    """
    function(filePath, data) {
        var fs = Java.type('java.nio.file.Files');
        var Paths = Java.type('java.nio.file.Paths');
        var path = Paths.get(filePath);
        var json = JSON.stringify(data, null, 2);
        try {
            fs.write(path, json.getBytes());
            karate.log('Successfully written to file:', filePath);
        } catch (e) {
            karate.log('Error writing to file:', e.message);
        }
    }
    """
    * writeToFile('src/test/resources/data/CreatedCouponData.json', response)



