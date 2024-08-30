Feature: Registration and Login

  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }

  Scenario: Register and login with random data
# Get the random values
    * def random =
"""
function() {
return {
email: 'user' + Math.random().toString(36).substring(7) + '@domain.com',
username: 'user' + Math.random().toString(36).substring(7),
password: 'test@123',
role: 'ADMIN'
};
}
"""
    * def randomData = random()

# Request payload for registration
    * def requestPayload1 =
"""
{
"email": "#(randomData.email)",
"password": "#(randomData.password)",
"role": "#(randomData.role)",
"username": "#(randomData.username)"
}
"""

    Given url 'https://api.freeapi.app/api/v1/users/register'
    And headers request_headers
    And request requestPayload1
    When method post
    Then status 201
    * def registeredUser = response
    * print response

# Request payload for login
    * def requestPayload2 =
"""
{
"username": "#(randomData.username)",
"password": "#(randomData.password)"
}
"""

    Given url 'https://api.freeapi.app/api/v1/users/login'
    And headers request_headers
    And request requestPayload2
    When method post
    Then status 200
    * print response
    * def response = response
    * def accessToken = response.data.accessToken
    * print 'Access Token :', accessToken
    * print response
