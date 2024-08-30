Feature: Create Booking and Validate XML Response
  Background:
    * def baseUrl = 'https://restful-booker.herokuapp.com'
    * def accessToken = null

  Scenario: Create a booking with XML data and validate the response
    # Define the XML payload
    Given def xmlPayload =
  """

  `
      <booking>
        <firstname>Jim</firstname>
        <lastname>Brown</lastname>
        <totalprice>111</totalprice>
        <depositpaid>true</depositpaid>
        <bookingdates>
          <checkin>2018-01-01</checkin>
          <checkout>2019-01-01</checkout>
        </bookingdates>
        <additionalneeds>Breakfast</additionalneeds>
      </booking>
    `

  """
    Given url baseUrl + '/booking'
    And header Content-Type = 'text/xml'
    And request xmlPayload
    When method post

    Then status 200
    * def responseXml = karate.response
    * def responseJson = karate.xmlToJson(responseXml)

    Then match responseJson.booking.firstname == 'Jim'
    And match responseJson.booking.lastname == 'Brown'
    And match responseJson.booking.totalprice == 111
    And match responseJson.booking.depositpaid == true
    And match responseJson.booking.bookingdates.checkin == '2018-01-01'
    And match responseJson.booking.bookingdates.checkout == '2019-01-01'
    And match responseJson.booking.additionalneeds == 'Breakfast'