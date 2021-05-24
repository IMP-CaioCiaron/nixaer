import 'package:flutter/material.dart';
import 'package:nixaer/connection/requestcontroller.dart';

Widget formatOutput(String metric, List data, int index){
  switch(metric){
    case 'Sensação térmica':
      return Row(
          children: [
            Text('$metric: ${RequestController.getTemperatureApparent(data, index)}ºC',)
          ]
      );

    case 'Temperatura':
      return Row(
          children: [
            Text('$metric: ${RequestController.getTemperature(data, index)}ºC',)
          ]
      );

    case 'Humidade':
      return Row(
          children:[
            Text('$metric: ${RequestController.getHumidity(data, index)}%')
          ]
      );

    case 'Velocidade do vento':
      return Row(
          children: [
            Text('$metric: ${RequestController.getWindSpeed(data, index)} m/s')
          ]
      );

    case 'Direção do vento':
      return Row(
        children: [
          Text('$metric: ${RequestController.getWindDirection(data, index)}º')
        ],
      );

    case 'Pressão na superfície':
      return Row(
        children: [
          Text('$metric: ${RequestController.getPressureSurface(data, index)} hPa')
        ],
      );

    case 'Chance de precipitação':
      return Row(
        children: [
          Text('$metric: ${RequestController.getprecipitationChance(data, index)}%')
        ],
      );
  }
  return Row(children: [
    Text('Algo deu errado! Tente novamente.')
  ],);
}








