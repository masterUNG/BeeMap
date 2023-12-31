// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:beemap/models/bee_model.dart';
import 'package:beemap/models/user_model.dart';
import 'package:beemap/states/main_home.dart';
import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/utility/app_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> findPhoneNumber() async {
    await GetStorage.init();

    GetStorage box = GetStorage();
    var result = await box.read('phoneNumber');
    print('##19aug result ---> $result');

    if (result != null) {
      appController.phoneNumbers.add(result);
    }
  }

  Future<void> processFindPosition() async {
    bool locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    if (locationServiceEnable) {
      //Enable Location

      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //ไม่อนุญาติเลย
        dialogCallLocation();
      } else {
        //Away, OneInUser, Deny

        if (locationPermission == LocationPermission.denied) {
          //ยังไม่รู่ว่าอนุญาติ หรือเปล่า ???

          locationPermission = await Geolocator.requestPermission();
          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            //DeniedForver
            dialogCallLocation();
          } else {
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          // Away, OneInUse
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      // Off Service Loaction
      AppDialog(title: 'กรุณาเปิด Location ด้วย').normalDialog(
          firstAction: TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                exit(0);
              },
              child: const Text('Enable Location Service')));
    }
  }

  void dialogCallLocation() {
    AppDialog(title: 'กรุณาเปิด Permission Location ด้วยคะ').normalDialog(
        firstAction: TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
              exit(0);
            },
            child: const Text('Open Permission')));
  }

  Future<void> checkDistance() async {
    String url = 'https://www.androidthai.in.th/fluttertraining/getAllbee.php';
    await Dio().get(url).then((value) {
      double distance = 0.0;

      for (var element in json.decode(value.data)) {
        BeeModel model = BeeModel.fromMap(element);

        double myDistance = calculateDistance(
            appController.positions.last.latitude,
            appController.positions.last.longitude,
            double.parse(model.lat),
            double.parse(model.lng));

        if (distance == 0.0) {
          appController.beeModels.add(model);
          distance = myDistance;
        }

        if (distance > myDistance) {
          distance = myDistance;
          appController.beeModels.add(model);
        }
      }
    });
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<void> processCreateNewAccount(
      {required String name,
      required String user,
      required String password}) async {
    String urlApiCheckUser =
        'https://www.androidthai.in.th/fluttertraining/getUserBee.php?isAdd=true&user=$user';

    await Dio().get(urlApiCheckUser).then((value) async {
      print('ค่าที่จาก api Check User ---> $value');

      if (value.toString() == 'null') {
        //User OK

        String urlInsertData =
            'https://www.androidthai.in.th/fluttertraining/insertBeeUser.php?isAdd=true&name=$name&user=$user&password=$password';
        await Dio().get(urlInsertData).then((value) {
          Get.back();
          Get.snackbar('Welcome', 'Create Account Success Please Login');
        });
      } else {
        Get.snackbar('User ซ้ำ', 'เปลี่ยน User ใหม่ User ช้ำ');
      }
    });
  }

  Future<void> checkLogin(
      {required String user, required String password}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/getUserBee.php?isAdd=true&user=$user';

    await Dio().get(urlApi).then((value) async {
      if (value.toString() == 'null') {
        //user False หรือ user ไม่มี
        Get.snackbar('User False', 'ไม่มี user นีใน ฐานข้อมูลของเรา');
      } else {
        print('value ---> $value');

        var result = json.decode(value.data);
        print('result ------> $result');

        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (userModel.password == password) {
            //password true

            var datas = <String>[];
            datas.add(userModel.id);
            datas.add(userModel.name);

            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setStringList('datas', datas).then((value) {
              Get.offAll(const MainHome());
              Get.snackbar(
                  'Welcome', 'ยินดีต้อนรับ ${userModel.name} สู่แอพของเรา');
            });
          } else {
            Get.snackbar('Password false', 'Please Check Password False');
          }
        }
      }
    });
  }
}
