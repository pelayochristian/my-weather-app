/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-11-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/

@IsTest
public class MW_OpenWeather_Test {
    // This test method should give 100% coverage
    static testMethod void testParse() {
        System.debug('Test22 CI');
        String json =
            '{' +
            '\"coord\": {' +
            '\"lon\": 122,' +
            '\"lat\": 13' +
            '},' +
            '\"weather\": [' +
            '{' +
            '\"id\": 804,' +
            '\"main\": \"Clouds\",' +
            '\"description\": \"overcast clouds\",' +
            '\"icon\": \"04d\"' +
            '}' +
            '],' +
            '\"base\": \"stations\",' +
            '\"main\": {' +
            '\"temp\": 302.71,' +
            '\"feels_like\": 307.58,' +
            '\"temp_min\": 302.71,' +
            '\"temp_max\": 302.71,' +
            '\"pressure\": 1007,' +
            '\"humidity\": 72,' +
            '\"sea_level\": 1007,' +
            '\"grnd_level\": 1007' +
            '},' +
            '\"visibility\": 10000,' +
            '\"wind\": {' +
            '\"speed\": 2.86,' +
            '\"deg\": 109,' +
            '\"gust\": 2.92' +
            '},' +
            '\"clouds\": {' +
            '\"all\": 97' +
            '},' +
            '\"dt\": 1656908271,' +
            '\"sys\": {' +
            '\"country\": \"PH\",' +
            '\"sunrise\": 1656883802,' +
            '\"sunset\": 1656930136' +
            '},' +
            '\"timezone\": 28800,' +
            '\"id\": 1694008,' +
            '\"name\": \"Philippines\",' +
            '\"cod\": 200' +
            '}';
        MW_OpenWeather r = MW_OpenWeather.parse(json);
        System.assert(r != null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Weather objWeather = new MW_OpenWeather.Weather(
            System.JSON.createParser(json)
        );
        System.assert(objWeather != null);
        System.assert(objWeather.id == null);
        System.assert(objWeather.main == null);
        System.assert(objWeather.description == null);
        System.assert(objWeather.icon == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Coord objCoord = new MW_OpenWeather.Coord(
            System.JSON.createParser(json)
        );
        System.assert(objCoord != null);
        System.assert(objCoord.lon == null);
        System.assert(objCoord.lat == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Wind objWind = new MW_OpenWeather.Wind(
            System.JSON.createParser(json)
        );
        System.assert(objWind != null);
        System.assert(objWind.speed == null);
        System.assert(objWind.deg == null);
        System.assert(objWind.gust == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Clouds objClouds = new MW_OpenWeather.Clouds(
            System.JSON.createParser(json)
        );
        System.assert(objClouds != null);
        System.assert(objClouds.all == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather objMW_OpenWeather = new MW_OpenWeather(
            System.JSON.createParser(json)
        );
        System.assert(objMW_OpenWeather != null);
        System.assert(objMW_OpenWeather.coord == null);
        System.assert(objMW_OpenWeather.weather == null);
        System.assert(objMW_OpenWeather.base == null);
        System.assert(objMW_OpenWeather.main == null);
        System.assert(objMW_OpenWeather.visibility == null);
        System.assert(objMW_OpenWeather.wind == null);
        System.assert(objMW_OpenWeather.clouds == null);
        System.assert(objMW_OpenWeather.dt == null);
        System.assert(objMW_OpenWeather.sys == null);
        System.assert(objMW_OpenWeather.timezone == null);
        System.assert(objMW_OpenWeather.id == null);
        System.assert(objMW_OpenWeather.name == null);
        System.assert(objMW_OpenWeather.cod == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Sys objSys = new MW_OpenWeather.Sys(
            System.JSON.createParser(json)
        );
        System.assert(objSys != null);
        System.assert(objSys.country == null);
        System.assert(objSys.sunrise == null);
        System.assert(objSys.sunset == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        MW_OpenWeather.Main objMain = new MW_OpenWeather.Main(
            System.JSON.createParser(json)
        );
        System.assert(objMain != null);
        System.assert(objMain.temp == null);
        System.assert(objMain.feels_like == null);
        System.assert(objMain.temp_min == null);
        System.assert(objMain.temp_max == null);
        System.assert(objMain.pressure == null);
        System.assert(objMain.humidity == null);
        System.assert(objMain.sea_level == null);
        System.assert(objMain.grnd_level == null);
    }
}
