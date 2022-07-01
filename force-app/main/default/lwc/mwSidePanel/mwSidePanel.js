/**
 * @description       : Side Panel Section contains the business logic of the components.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-01-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";

export default class MwSidePanel extends LightningElement {
    // SVG Icons
    partlyCloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`;
    cloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`;
    rain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/rain.svg`;
    thunderstormsDayRain = `${WEATHER_ICON_SVG}/thunderstorms-day-rain.svg`;

    renderedCallback() {
        console.log("@@@CHAN => ", this.svgIcon1);
    }
}