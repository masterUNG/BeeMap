import 'package:beemap/models/bee_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList<Position> positions = <Position>[].obs;

  RxList<String> phoneNumbers = <String>[].obs;

  RxList<BeeModel> beeModels = <BeeModel>[].obs;

  RxBool accept = false.obs;

  RxList<String> datas = <String>[].obs;

  RxList<DateTime> chooseDateTimes = <DateTime>[].obs;

  RxList<TimeOfDay> chooseTimeOfDays = <TimeOfDay>[].obs;
}
