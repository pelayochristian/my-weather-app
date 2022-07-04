/**
 * @description       : Main Panel Contains the business logic of the component.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-05-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/

import { LightningElement, wire } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";
import getCurrentWeatherForecastService from "@salesforce/apex/MW_OpenWeatherController.getCurrentWeatherForecastService";
export default class MwMainPanel extends LightningElement {
    partlyCloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`;
    cloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`;
    rain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/rain.svg`;
    thunderstormsDayRain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-rain.svg`;
    compass = `${WEATHER_ICON_SVG}/meteocons-weather-icons/compass.svg`;
    codeGreenIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-green.svg`;
    codeYellowIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-yellow.svg`;
    codeRedIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-red.svg`;
    codeOrangeIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-orange.svg`;
    uvIndex5Icon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/uv-index-5.svg`;
    timeMorning = `${WEATHER_ICON_SVG}/meteocons-weather-icons/time-morning.svg`;

    @wire(getCurrentWeatherForecastService, {
        longitude: 122,
        latitude: 13,
        unitType: "metric"
    })
    getCurrentWeatherForecastService({ error, data }) {
        if (data) {
            console.log("@@@CHAN data -> ", data);
        } else {
            console.log("@@@CHAN error -> ", error);
        }
    }
}
