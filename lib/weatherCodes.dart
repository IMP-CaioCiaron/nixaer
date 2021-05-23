import 'dart:io' as io;

class WeatherCodes{
  static final Map<String, String> WEATHERCODES = {
    "0": "Unknown",
    "1000": "Clear",
    "1001": "Cloudy",
    "1100": "Mostly Clear",
    "1101": "Partly Cloudy",
    "1102": "Mostly Cloudy",
    "2000": "Fog",
    "2100": "Light Fog",
    "3000": "Light Wind",
    "3001": "Wind",
    "3002": "Strong Wind",
    "4000": "Drizzle",
    "4001": "Rain",
    "4200": "Light Rain",
    "4201": "Heavy Rain",
    "5000": "Snow",
    "5001": "Flurries",
    "5100": "Light Snow",
    "5101": "Heavy Snow",
    "6000": "Freezing Drizzle",
    "6001": "Freezing Rain",
    "6200": "Light Freezing Rain",
    "6201": "Heavy Freezing Rain",
    "7000": "Ice Pellets",
    "7101": "Heavy Ice Pellets",
    "7102": "Light Ice Pellets",
    "8000": "Thunderstorm"
  };

  static getPeriodDay(String currentHour){
   int hourTruncated = int.parse(currentHour.substring(11, 13));
   String periodDay = 'undefined';
   if (hourTruncated < 19 && hourTruncated >= 6){
     periodDay = 'day';
   }
   else{
     periodDay = 'night';
   }
   return periodDay;

  }

  static getWeatherImgName(Map<String, dynamic> interval){

    String weatherCode = interval['values']['weatherCode'].toString();

    String weatherCodeDesc = WEATHERCODES[weatherCode].toLowerCase();

    String imageName = weatherCodeDesc.replaceAll(RegExp(r' '), '_') + '.svg';

    return imageName;

  }

}
