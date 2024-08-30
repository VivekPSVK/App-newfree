Feature: User Login

  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }

  Scenario Outline: Login with various credentials


    * def requestPayload =
    """
    {
        "username": "#(username)",
        "password": "#(password)"
    }
    """

    # Perform login
    Given url 'https://api.freeapi.app/api/v1/users/login'
    And headers request_headers
    And request requestPayload
    When method post
    Then status 200
    * print response
    * def response = response
    * def accessToken = response.data.accessToken
    * print 'Access Token :', accessToken

    #Examples:
      #| read('classpath:data/login-data.csv') |

  Examples:
      | username   | password |
      | user41k5k | test@123 |
      | userttcw5f | test@123 |
      | userr2qef  | test@123 |

