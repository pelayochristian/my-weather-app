/**
 * @description       : Side Panel Section contains the business logic of the components.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-05-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
import { LightningElement, wire } from "lwc";
import WEATHER_ICON_SVG from "@salesforce/resourceUrl/MWMeteocons";
import getCurrentWeatherForecastService from "@salesforce/apex/MW_OpenWeatherController.getCurrentWeatherForecastService";
import CITY_IMAGE from "@salesforce/resourceUrl/MWAssets";

const weatherIcons = {
    "01d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/clear-day.svg`,
    "01n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/clear-night.svg`,
    "02d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`,
    "02n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-night.svg`,
    "03d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`,
    "03n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`,
    "04d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day.svg`,
    "04n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night.svg`,
    "09d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day-drizzle.svg`,
    "09n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night-drizzle.svg`,
    "10d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-day-rain.svg`,
    "10n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/overcast-night-rain.svg`,
    "11d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-day-extreme.svg`,
    "11n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/thunderstorms-night-extreme.svg`,
    "13d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day-snow.svg`,
    "13n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-night-snow.svg`,
    "50d": `${WEATHER_ICON_SVG}/meteocons-weather-icons/mist.svg`,
    "50n": `${WEATHER_ICON_SVG}/meteocons-weather-icons/mist.svg`
};

export default class MwSidePanel extends LightningElement {
    // SVG Icons
    //partlyCloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/partly-cloudy-day.svg`;
    cloudy = `${WEATHER_ICON_SVG}/meteocons-weather-icons/cloudy.svg`;
    rain = `${WEATHER_ICON_SVG}/meteocons-weather-icons/rain.svg`;
    //thunderstormsDayRain = `${WEATHER_ICON_SVG}/thunderstorms-day-rain.svg`;
    cityImage = `${CITY_IMAGE}/mw-assets/city2.jpeg`;

    currentTemperature = 0;
    currentWeatherIcon = "";
    isDataAvailable = false;
    currentDateTime = null;
    currentDay = null;
    currentTime = null;
    currentLocation = "";
    cloudyPercentage = 0;
    weatherDescription = "";

    @wire(getCurrentWeatherForecastService, {
        longitude: 123.891,
        latitude: 10.317,
        unitType: "metric"
    })
    getCurrentWeatherForecastService({ error, data }) {
        if (data) {
            this.isDataAvailable = true;
            this.currentTemperature = Math.round(data.main.temp);
            this.getCurrentWeatherIcon(data.weather);
            this.currentDateTime = new Date(data.dt * 1000);
            this.currentLocation = `${data.name}, ${data.sys.country}`;
            this.cloudyPercentage = data.clouds.all;
            this.currentDay = this.currentDateTime.toLocaleString("en-us", {
                weekday: "long"
            });
            this.currentTime =
                this.currentDateTime.getHours() +
                ":" +
                this.currentDateTime.getMinutes();
            console.log("@@@CHAN data -> ", data);
        } else {
            console.log(
                "Error in MwSidePanel.getCurrentWeatherForecastService() :",
                error
            );
        }
    }

    /**
     * Get the weather icon value from the response and
     * return the correct mapping of the custom weather icons
     * from the weatherIcons Object.
     * @param {Object} weather
     * @returns void
     */
    getCurrentWeatherIcon(weather) {
        if (weather == null) return;
        this.weatherDescription = weather[0].description;
        this.currentWeatherIcon = JSON.parse(
            JSON.stringify(weatherIcons[weather[0].icon])
        );
    }

    get locationBackgroundStyle() {
        return `background-image: linear-gradient(
                rgba(0, 0, 0, 0.5), 
                rgba(0, 0, 0, 0.5)),
                url("${this.cityImage}"); 
                background-position: center; 
                background-repeat: no-repeat; 
                background-size: cover;`;
    }
}
