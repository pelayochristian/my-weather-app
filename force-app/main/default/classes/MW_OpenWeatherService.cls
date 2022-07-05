/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-05-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherService {
    private static final String OW_CURRENT_WEATHER_API = 'data/2.5/weather';
    private static final String API_KEY = '8aebdc1199ded002eb077a3e12dadab2';
    private static final Integer DEFAULT_LATITUDE = 13;
    private static final Integer DEFAULT_LONGITUDE = 122;
    private static final String UNIT_METRIC = 'METRIC';
    private static final String UNIT_IMPLERIAL = 'IMPLERIAL';

    /**
     * @description Method used for retrieving the Open Weather
     *              API Key from Custom Metada.
     * @author pelayochristian.dev@gmail.com | 07-04-2022
     * @return String
     **/
    private static String getOpenWeatherKey() {
        return null;
    }

    /**
     * @description
     * @author pelayochristian.dev@gmail.com | 07-04-2022
     * @param longitude
     * @param latitude
     * @param unitType
     * @return MW_OpenWeather
     **/
    public static MW_OpenWeather getCurrentWeatherForecast(
        Decimal longitude,
        Decimal latitude,
        String unitType
    ) {
        MW_OpenWeather currentWeather = null;

        try {
            longitude = longitude == null ? DEFAULT_LONGITUDE : longitude;
            latitude = latitude == null ? DEFAULT_LATITUDE : latitude;
            unitType = unitType == null ? UNIT_METRIC : unitType;

            String endPoint =
                'callout:Open_Weather_Service/' +
                OW_CURRENT_WEATHER_API +
                '?lat=' +
                latitude +
                '&lon=' +
                longitude +
                '&units=' +
                unitType +
                '&appId=' +
                API_KEY;

            System.debug('@@@CHAN -> ' + endPoint);

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(endPoint);
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
