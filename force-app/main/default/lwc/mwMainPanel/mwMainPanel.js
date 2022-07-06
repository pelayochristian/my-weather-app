/**
 * @description       : Main Panel Contains the business logic of the component.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-06-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/

import { LightningElement } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";
import { registerListener, unregisterListener } from "c/pubsub";
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
    sunriseIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/sunrise.svg`;
    sunsetIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/sunset.svg`;

    uviIconsIndicator;

    // Todays Highlight Attributes
    uvi;
    windStatus = 0;
    sunrise = "";
    sunset = "";
    humidity = 0;
    visibility = 0;
    wind_deg = 0;
    windDirection = "";

    // payload checker
    isUVIAvailable = false;
    isWindStatusAvailable = false;
    isHumidityAvailable = false;
    isVisibilityAvailable = false;
    isWindDirectionAvailable = false;
    isSunsetSunriseAvailable = false;

    // miscellaneous
    uvRadiationLevel;
    visibilityLevel;
    visibilityAlertLevelIcon;
    humidityAlertLevelIcon;
    humidityLevel;

    connectedCallback() {
        // Subscribe todaysHighlightEvt
        registerListener(
            "todaysHighlightEvt",
            this.handleTodaysHighlightEvt,
            this
        );
    }

    disconnectedCallback() {
        // Unsubscribe todaysHighlightEvt
        unregisterListener(
            "todaysHighlightEvt",
            this.handleTodaysHighlightEvt,
            this
        );
    }

    /**
     * Subscriber function for the 'todaysHighlightEvt' which
     * contains the todays highlight attributes.
     * @param {Object} payload
     */
    handleTodaysHighlightEvt(payload) {
        // WIND STATUS
        this.isWindStatusAvailable = payload.wind_speed ? true : false;
        this.windStatus = payload.wind_speed.toFixed(1);
        // UVI
        this.setUVIndexPanelAttributes(payload);
        // HUMIDITY
        this.setHumidityPanelAttributes(payload);
        // VISIBILITY
        this.setVisibilityPanelAttributes(payload);

        // WIND DEGREE
        this.isWindDirectionAvailable = payload.wind_deg ? true : false;
        this.windDirection = this.getCardinalDirection(payload.wind_deg);

        // SUNSET & SUNRISE
        this.isSunsetSunriseAvailable =
            payload.sunrise && payload.sunrise ? true : false;
        // Convert sunrise and sunset epoch time to readable format
        let sunriseDT = new Date(payload.sunrise * 1000);
        this.sunrise = sunriseDT.toLocaleString("en-US", {
            hour: "numeric",
            minute: "numeric",
            hour12: true
        });

        let sunsetDT = new Date(payload.sunset * 1000);
        this.sunset = sunsetDT.toLocaleString("en-US", {
            hour: "numeric",
            minute: "numeric",
            hour12: true
        });
    }

    /**
     * Method used for setting up the necessary
     * attributes in Humidity Panel.
     * @param {Object} payload
     */
    setHumidityPanelAttributes(payload) {
        const CRITICAL_HIGH = 70,
            HIGH_MAX = 70,
            HIGH_MIN = 60,
            NORMAL_MAX = 60,
            NORMAL_MIN = 30,
            LOW_MAX = 30,
            LOW_MIN = 25,
            CRITICAL_LOW = 25;
        this.isHumidityAvailable = payload.humidity ? true : false;
        this.humidity = payload.humidity;
        if (this.humidity >= CRITICAL_HIGH) {
            this.humidityLevel = "Poor high humidity";
            this.humidityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-red.svg`;
        } else if (this.humidity >= HIGH_MIN && this.humidity < HIGH_MAX) {
            this.humidityLevel = "Fair";
            this.humidityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-orange.svg`;
        } else if (this.humidity >= NORMAL_MIN && this.humidity < NORMAL_MAX) {
            this.humidityLevel = "Maintain your healthy";
            this.humidityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-green.svg`;
        } else if (this.humidity >= LOW_MIN && this.humidity < LOW_MAX) {
            this.humidityLevel = "Fair";
            this.humidityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-orange.svg`;
        } else if (this.humidityAlertLevelIcon < CRITICAL_LOW) {
            this.humidityLevel = "Poor low humidity";
            this.humidityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-red.svg`;
        }
    }

    /**
     * Method used for setting up the necessary
     * attributes in Visibility Panel.
     * @param {Object} payload
     */
    setVisibilityPanelAttributes(payload) {
        const DENSE_FOG = 0.05,
            THICK_FOG_MIN = 0.05,
            THICK_FOG_MAX = 0.2,
            MODERATE_FOG_MIN = 0.2,
            MODERATE_FOG_MAX = 0.5,
            LIGHT_FOG_MIN = 0.5,
            LIGHT_FOG_MAX = 1,
            THIN_FOG_MIN = 1,
            THIN_FOG_MAX = 2,
            HAZE_MIN = 2,
            HAZE_MAX = 4,
            LIGHT_HAZE_MIN = 4,
            LIGHT_HAZE_MAX = 10,
            CLEAR = 10;
        this.isVisibilityAvailable = payload.visibility ? true : false;
        this.visibility = (payload.visibility / 1000).toFixed(1);
        if (this.visibility < DENSE_FOG) {
            // Code Red
            this.visibilityLevel = "Dense fog";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-red.svg`;
        } else if (
            this.visibility >= THICK_FOG_MIN &&
            this.visibility < THICK_FOG_MAX
        ) {
            this.visibilityLevel = "Thick fog";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-red.svg`;
        } else if (
            // Code Orange
            this.visibility >= MODERATE_FOG_MIN &&
            this.visibility < MODERATE_FOG_MAX
        ) {
            this.visibilityLevel = "Moderate Fog";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-orange.svg`;
        } else if (
            this.visibility >= LIGHT_FOG_MIN &&
            this.visibility < LIGHT_FOG_MAX
        ) {
            this.visibilityLevel = "Light Fog";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-orange.svg`;
        } else if (
            // Code Yellow
            this.visibility >= THIN_FOG_MIN &&
            this.visibility < THIN_FOG_MAX
        ) {
            this.visibilityLevel = "Thin Fog";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-yellow.svg`;
        } else if (this.visibility >= HAZE_MIN && this.visibility < HAZE_MAX) {
            this.visibilityLevel = "Haze";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-yellow.svg`;
        } else if (
            // Code Green
            this.visibility >= LIGHT_HAZE_MIN &&
            this.visibility < LIGHT_HAZE_MAX
        ) {
            this.visibilityLevel = "Light Haze";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-green.svg`;
        } else if (this.visibility >= CLEAR) {
            this.visibilityLevel = "Clear";
            this.visibilityAlertLevelIcon = `${WEATHER_ICON_SVG}/meteocons-weather-icons/code-green.svg`;
        }
    }

    /**
     * Method used for setting up the necessary
     * attributes in UV Index Panel.
     * @param {Object} payload
     */
    setUVIndexPanelAttributes(payload) {
        const LOW_MIN = 0,
            LOW_MAX = 2,
            MODERATE_MIN = 3,
            MODERATE_MAX = 5,
            HIGH_MIN = 6,
            HIGH_MAX = 7,
            VERY_HIGH_MIN = 8,
            VERY_HIGH_MAX = 10,
            EXTREME_MIN = 11;

        this.isUVIAvailable = payload.uvi || payload.uvi === 0 ? true : false;
        this.uvi = Math.round(payload.uvi);
        this.uviIconsIndicator =
            this.uvi === 0
                ? `${WEATHER_ICON_SVG}/meteocons-weather-icons/uv-index.svg`
                : (this.uviIconsIndicator = `${WEATHER_ICON_SVG}/meteocons-weather-icons/uv-index-${this.uvi}.svg`);

        // UV Radiation Scale Conditions
        if (this.uvi >= LOW_MIN && this.uvi <= LOW_MAX) {
            this.uvRadiationLevel = "Low";
        } else if (this.uvi >= MODERATE_MIN && this.uvi <= MODERATE_MAX) {
            this.uvRadiationLevel = "Moderate";
        } else if (this.uvi >= HIGH_MIN && this.uvi <= HIGH_MAX) {
            this.uvRadiationLevel = "High";
        } else if (this.uvi >= VERY_HIGH_MIN && this.uvi <= VERY_HIGH_MAX) {
            this.uvRadiationLevel = "Very High";
        } else if (this.uvi >= EXTREME_MIN) {
            this.uvRadiationLevel = "Extreme";
        }
    }
    /**
     * Utility method to return Cardinal Direction by
     * consuming Direction angle.
     * @param {Integer} angle
     * @returns String
     */
    getCardinalDirection(angle) {
        var val = Math.floor(angle / 22.5 + 0.5);
        var arr = [
            "N",
            "NNE",
            "NE",
            "ENE",
            "E",
            "ESE",
            "SE",
            "SSE",
            "S",
            "SSW",
            "SW",
            "WSW",
            "W",
            "WNW",
            "NW",
            "NNW"
        ];
        return arr[val % 16];
    }
}
