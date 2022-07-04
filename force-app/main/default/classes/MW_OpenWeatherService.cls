/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-04-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherService {
    private static final String OW_CURRENT_WEATHER_API = 'data/2.5/weather';

    /**
     * Weather Units in ENUM
     */
    public enum Unit {
        METRIC,
        IMPERIAL,
        STANDARD
    }

    /**
     * @description Method used for retrieving the Open Weather
     *              API Key from Custom Metada.
     * @author pelayochristian.dev@gmail.com | 07-04-2022
     * @return String
     **/
    private static String getOpenWeatherKey() {
        String openWeatherAPIKey = '';
        try {
            List<My_Weather_Config__mdt> myConfigs = [
                SELECT Id, MasterLabel, Value__c, QualifiedApiName
                FROM My_Weather_Config__mdt
                WHERE QualifiedApiName = 'Open_Weather_API_Key'
                WITH SECURITY_ENFORCED
            ];

            if (myConfigs.size() > 0) {
                openWeatherAPIKey = myConfigs[0].Value__c;
            }
        } catch (Exception ex) {
            System.debug(
                'Error : MW_OpenWeather.getOpenWeatherKey() with message ' +
                ex.getMessage()
            );
        }
        return openWeatherAPIKey;
    }

    /**
     * @description Method used for calling the Open Weather
     *              Rest-Endpoint and return the current weather
     *              forecast.
     * @author pelayochristian.dev@gmail.com | 07-04-2022
     * @param longitude
     * @param latitude
     * @return MW_OpenWeather
     **/
    public static MW_OpenWeather getCurrentWeatherForecast(
        Integer longitude,
        Integer latitude,
        Unit unit
    ) {
        MW_OpenWeather currentWeather = null;

        try {
            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(
                'callout:Open_Weather_Service/' +
                OW_CURRENT_WEATHER_API +
                '?lat=' +
                longitude +
                '&lon=' +
                latitude +
                '&units=' +
                'metric' +
                '&appId=' +
                getOpenWeatherKey()
            );
            httpRequest.setMethod('GET');
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                currentWeather = MW_OpenWeather.parse(httpResponse.getBody());
            }
        } catch (Exception ex) {
            System.debug(
                'Error : MW_OpenWeather.getCurrentWeatherForecast() with message ' +
                ex.getMessage()
            );
        }
        return currentWeather;
    }
}
