Feature: Add address to the profile
  Background:
    * def request_headers = { accept: 'application/json', 'Content-Type': 'application/json' }
    * def FakerUtiles = Java.type('utiles.FakerUtiles')
    * def fakeAddress = FakerUtiles.genrateAddress()

    Scenario: add address to the profile using java faker
        Given url 'https://api.freeapi.app/api/v1/ecommerce/addresses'
        And headers request_headers
      And request fakeAddress
      When method post
      Then status 201
      And print response
      * def addressData = response

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
      * writeToFile('src/test/resources/data/AddressData.txt', response)