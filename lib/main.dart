import 'dart:io';

import 'package:beemap/states/authen.dart';
import 'package:beemap/states/main_home.dart';
import 'package:beemap/states/show_map.dart';
import 'package:beemap/utility/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var getPage = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  ),
];

String? firstPage;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var datas = sharedPreferences.getStringList('datas');
  print('นี่คื่อค่า datas ที่อ่านได้จาก main.dart ---> $datas');

  if (datas == null) {
    //ไม่ได้ login
    firstPage = '/authen';
    runApp(const MyApp());
  } else {
    // Login อยู่

    AppController appController = Get.put(AppController());
    appController.datas.addAll(datas);

    firstPage = '/mainHome';
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      getPages: getPage,
      initialRoute: firstPage,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
