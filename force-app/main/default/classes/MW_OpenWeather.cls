/**
 * @description       :
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-05-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public class MW_OpenWeather {
    public class Weather {
        @AuraEnabled
        public Integer id { get; set; }
        @AuraEnabled
        public String main { get; set; }
        @AuraEnabled
        public String description { get; set; }
        @AuraEnabled
        public String icon { get; set; }

        public Weather(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'id') {
                            id = parser.getIntegerValue();
                        } else if (text == 'main') {
                            main = parser.getText();
                        } else if (text == 'description') {
                            description = parser.getText();
                        } else if (text == 'icon') {
                            icon = parser.getText();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Weather consuming unrecognized property: ' +
                                text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Coord {
        @AuraEnabled
        public Integer lon { get; set; }
        @AuraEnabled
        public Integer lat { get; set; }

        public Coord(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'lon') {
                            lon = parser.getIntegerValue();
                        } else if (text == 'lat') {
                            lat = parser.getIntegerValue();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Coord consuming unrecognized property: ' + text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Wind {
        @AuraEnabled
        public Double speed { get; set; }
        @AuraEnabled
        public Integer deg { get; set; }
        @AuraEnabled
        public Double gust { get; set; }

        public Wind(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'speed') {
                            speed = parser.getDoubleValue();
                        } else if (text == 'deg') {
                            deg = parser.getIntegerValue();
                        } else if (text == 'gust') {
                            gust = parser.getDoubleValue();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Wind consuming unrecognized property: ' + text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Clouds {
        @AuraEnabled
        public Integer all { get; set; }

        public Clouds(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'all') {
                            all = parser.getIntegerValue();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Clouds consuming unrecognized property: ' +
                                text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    @AuraEnabled
    public Coord coord { get; set; }
    @AuraEnabled
    public List<Weather> weather { get; set; }
    @AuraEnabled
    public String base { get; set; }
    @AuraEnabled
    public Main main { get; set; }
    @AuraEnabled
    public Integer visibility { get; set; }
    @AuraEnabled
    public Wind wind { get; set; }
    @AuraEnabled
    public Clouds clouds { get; set; }
    @AuraEnabled
    public Integer dt { get; set; }
    @AuraEnabled
    public Sys sys { get; set; }
    @AuraEnabled
    public Integer timezone { get; set; }
    @AuraEnabled
    public Integer id { get; set; }
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public Integer cod { get; set; }

    public MW_OpenWeather(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'coord') {
                        coord = new Coord(parser);
                    } else if (text == 'weather') {
                        weather = arrayOfWeather(parser);
                    } else if (text == 'base') {
                        base = parser.getText();
                    } else if (text == 'main') {
                        main = new Main(parser);
                    } else if (text == 'visibility') {
                        visibility = parser.getIntegerValue();
                    } else if (text == 'wind') {
                        wind = new Wind(parser);
                    } else if (text == 'clouds') {
                        clouds = new Clouds(parser);
                    } else if (text == 'dt') {
                        dt = parser.getIntegerValue();
                    } else if (text == 'sys') {
                        sys = new Sys(parser);
                    } else if (text == 'timezone') {
                        timezone = parser.getIntegerValue();
                    } else if (text == 'id') {
                        id = parser.getIntegerValue();
                    } else if (text == 'name') {
                        name = parser.getText();
                    } else if (text == 'cod') {
                        cod = parser.getIntegerValue();
                    } else {
                        System.debug(
                            LoggingLevel.WARN,
                            'MW_OpenWeather consuming unrecognized property: ' +
                            text
                        );
                        consumeObject(parser);
                    }
                }
            }
        }
    }

    public class Sys {
        @AuraEnabled
        public String country { get; set; }
        @AuraEnabled
        public Integer sunrise { get; set; }
        @AuraEnabled
        public Integer sunset { get; set; }

        public Sys(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'country') {
                            country = parser.getText();
                        } else if (text == 'sunrise') {
                            sunrise = parser.getIntegerValue();
                        } else if (text == 'sunset') {
                            sunset = parser.getIntegerValue();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Sys consuming unrecognized property: ' + text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Main {
        @AuraEnabled
        public Double temp { get; set; }
        @AuraEnabled
        public Double feels_like { get; set; }
        @AuraEnabled
        public Double temp_min { get; set; }
        @AuraEnabled
        public Double temp_max { get; set; }
        @AuraEnabled
        public Integer pressure { get; set; }
        @AuraEnabled
        public Integer humidity { get; set; }
        @AuraEnabled
        public Integer sea_level { get; set; }
        @AuraEnabled
        public Integer grnd_level { get; set; }

        public Main(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'temp') {
                            temp = parser.getDoubleValue();
                        } else if (text == 'feels_like') {
                            feels_like = parser.getDoubleValue();
                        } else if (text == 'temp_min') {
                            temp_min = parser.getDoubleValue();
                        } else if (text == 'temp_max') {
                            temp_max = parser.getDoubleValue();
                        } else if (text == 'pressure') {
                            pressure = parser.getIntegerValue();
                        } else if (text == 'humidity') {
                            humidity = parser.getIntegerValue();
                        } else if (text == 'sea_level') {
                            sea_level = parser.getIntegerValue();
                        } else if (text == 'grnd_level') {
                            grnd_level = parser.getIntegerValue();
                        } else {
                            System.debug(
                                LoggingLevel.WARN,
                                'Main consuming unrecognized property: ' + text
                            );
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public static MW_OpenWeather parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new MW_OpenWeather(parser);
    }

    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (
                curr == System.JSONToken.START_OBJECT ||
                curr == System.JSONToken.START_ARRAY
            ) {
                depth++;
            } else if (
                curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY
            ) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }

    private static List<Weather> arrayOfWeather(System.JSONParser p) {
        List<Weather> res = new List<Weather>();
        if (p.getCurrentToken() == null)
            p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Weather(p));
        }
        return res;
    }
}
