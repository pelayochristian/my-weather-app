/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-06-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherOneCallController {
    @AuraEnabled(cacheable=true)
    public static MW_OpenWeatherOneCall getWeatherForecastService(
        Decimal longitude,
        Decimal latitude,
        String unitType
    ) {
        return MW_OpenWeatherOneCallService.getWeatherForecast(
            longitude,
            latitude,
            unitType
        );
    }
}
