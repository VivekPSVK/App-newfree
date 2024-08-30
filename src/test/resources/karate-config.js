function karateConfig() {
             var config = {
                    baseUrl: 'https://api.freeapi.app/api/v1',
                    accessToken: ''
                };

                if (!karate.get('accessToken')) {
                                var tokenResponse = karate.callSingle('classpath:feature/TC_01_UserRegistration.feature');
                                config.accessToken = tokenResponse.accessToken;
                                karate.set('accessToken', config.accessToken);
                                 karate.configure('headers', { Authorization: 'Bearer ' + config.accessToken });// Optionally set a global variable
                            } else {
                                config.accessToken = karate.get('accessToken');
                                 karate.configure('headers', { Authorization: 'Bearer ' + config.accessToken });// Use existing token
                            }

                            karate.log('Configuring Karate:', JSON.stringify(config));
            return config;



}




