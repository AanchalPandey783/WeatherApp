import 'dart:developer';

import 'package:get/get.dart';
import 'package:weather_getx/data/location_data.dart';
import 'package:weather_getx/data/weather_data.dart';
import 'package:weather_getx/repository/weather_repository.dart';



class HomeController extends GetxController {
  final WeatherRepository _repository = Get.find<WeatherRepository>();

  Rxn<LocationData> locationData = Rxn();

  Rxn<WeatherData> weatherData = Rxn();

  RxString infoText = '...'.obs;

  String get address =>
      "${locationData.value?.regionName}, ${locationData.value?.country}";

  String get temperature => "${weatherData.value?.temp}";

  Future<void> getCurrentLocation() async {
    print('before getCurrentLocaion');

    final LocationData? location = await _repository.getCurrentLocation();
    print('after getCurrentLocaion');
    locationData.value = location;
  }

  Future<void> getTemperatureForCurrentLocation() async {
    if (locationData.value != null) {
      weatherData.value =
      await _repository.getWeatherForLocation(locationData.value!);
      _getInfoText(weatherData.value?.temp);
    }
  }

  void _getInfoText(int? temperature) {
    if (temperature == null) {
      infoText.value = "Unknown!";
    } else if (temperature <= 0) {
      infoText.value =
      "Make sure to dress in warm clothes! It's freezing out there!";
    } else if (temperature <= 15) {
      infoText.value = "Put on a jacket so you don't get sick! ";
    } else {
      infoText.value = "Savor the weather, it's lovely! ";
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCurrentLocation();
    await getTemperatureForCurrentLocation();
  }
}