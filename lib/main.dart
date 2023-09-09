import 'dart:io';

import 'package:beemap/states/authen.dart';
import 'package:beemap/states/main_home.dart';
import 'package:beemap/states/show_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var getPage = <GetPage<dynamic>>[
  GetPage(name: '/authen', page: () => const Authen(),),
  GetPage(name: '/mainHome', page: () => const MainHome(),),
];

void main() {
  HttpOverrides.global = MyHttpOverride();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      getPages: getPage,
     initialRoute: '/authen',
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
