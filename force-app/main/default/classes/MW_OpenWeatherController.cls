/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-05-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public class MW_OpenWeatherController {
    @AuraEnabled(cacheable=true)
    public static MW_OpenWeather getCurrentWeatherForecastService(
        Decimal longitude,
        Decimal latitude,
        String unitType
    ) {
        return MW_OpenWeatherService.getCurrentWeatherForecast(
            longitude,
            latitude,
            unitType
        );
    }

    @AuraEnabled(cacheable=true)
    public static String callMethod() {
        String returnStr = '';
        try {
            returnStr = 'Test Method';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return returnStr;
    }
}
