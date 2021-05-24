class WeatherCodes{
  static final Map<String, String> WEATHERCODES = {
    "0": "Unknown",
    "1000": "clear.svg",
    "1001": "cloudy.svg",
    "1100": "mostly_clear.svg",
    "1101": "partly_cloudy.svg",
    "1102": "mostly_cloudy.svg",
    "2000": "fog.svg",
    "2100": "fog_light.svg",
    "3000": "wind_light.svg",
    "3001": "wind.svg",
    "3002": "wind_strong.svg",
    "4000": "drizzle.svg",
    "4001": "rain.svg",
    "4200": "rain_light.svg",
    "4201": "rain_heavy.svg",
    "5000": "snow.svg",
    "5001": "flurries.svg",
    "5100": "snow_light",
    "5101": "snow_heavy.svg",
    "6000": "freezing_drizzle.svg",
    "6001": "freezing_rain.svg",
    "6200": "freezing_rain_light.svg",
    "6201": "freezing_rain_heavy.svg",
    "7000": "ice_pellets.svg",
    "7101": "ice_pellets_heavy.svg",
    "7102": "ice_pellets_light.svg",
    "8000": "tstorm.svg"
  };

  static getWeatherImgName(int wCode, int currentTime){
    String fileName = WEATHERCODES[wCode.toString()];

    switch(wCode){
      case 1000:
      case 1100:
      case 1101:
        if (currentTime >= 18 || currentTime <= 05){
          fileName = fileName.substring(0, fileName.indexOf('.')) + '_night.svg';
        }
        break;

      default:
        break;
    }

    return fileName;
  }
}
