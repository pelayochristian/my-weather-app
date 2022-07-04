/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-04-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement, api } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";

export default class MwDayForecast extends LightningElement {
    thunderstormsDayRain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-rain.svg`;

    @api weatherIcons = "";

    renderedCallback() {}
}
