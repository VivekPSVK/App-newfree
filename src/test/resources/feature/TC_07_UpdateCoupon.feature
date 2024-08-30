Feature: Update the Coupon and Retrieve the Same Coupon ID

  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }

  # Read the JSON file to get the couponId
    * def jsonData = karate.read('classpath:data/CreatedCouponData.json')
    * print 'Read JSON Data:', jsonData
    * def couponId = jsonData.data._id
    * print 'Coupon ID:', couponId

  # Read the CSV file to get coupon details
    * def csvData = karate.read('classpath:data/UpdateCouponData.csv')
    * print 'Read CSV Data:', csvData
    * def couponData = csvData[0]

  Scenario: Update the coupon

    * def requestPayload4 =
  """
  {
    "couponCode": "#(couponData.couponCode)",
    "discountValue": #(couponData.discountValue),
    "name": "#(couponData.name)"
  }
  """
  # Send the update request
    Given url 'https://api.freeapi.app/api/v1/ecommerce/coupons/' + couponId
    And headers request_headers
    And request requestPayload4
    When method patch
    Then status 200
    * print response

# Get the updated Coupon
    Given url 'https://api.freeapi.app/api/v1/ecommerce/coupons/' + couponId
    And headers request_headers
    When method get
    Then status 200
    * print response

