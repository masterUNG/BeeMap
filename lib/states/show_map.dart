// ignore_for_file: avoid_print

import 'dart:math';

import 'package:beemap/states/setting.dart';
import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/utility/app_dialog.dart';
import 'package:beemap/utility/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  AppController appController = Get.put(AppController());
  Map<MarkerId, Marker> markers = {};
  bool show = false;

  @override
  void initState() {
    super.initState();

    AppService().findPhoneNumber().then((value) {
      print('##19aug ');
    });

    AppService().processFindPosition().then((value) {
      createMarker(
          lat: appController.positions.last.latitude,
          lng: appController.positions.last.longitude,
          title: 'คุณอยู่ที่นี่');
    });
  }

  void createMarker(
      {required double lat, required double lng, required String title}) {
    MarkerId markerId = MarkerId(Random().nextInt(100).toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title));

    markers[markerId] = marker;
    print('markers --> ${markers.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return appController.positions.isEmpty
              ? const SizedBox()
              : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(appController.positions.last.latitude,
                            appController.positions.last.longitude),
                        zoom: 16,
                      ),
                      onMapCreated: (controller) {},
                      markers: Set<Marker>.of(markers.values),
                    ),
                    Positioned(
                        right: 32,
                        top: 16,
                        child: IconButton(
                            onPressed: () {
                              Get.to(const Setting());
                            },
                            icon: const Icon(
                              Icons.settings,
                              size: 36,
                            ))),
                    show
                        ? Positioned(
                            top: 32,
                            left: 32,
                            child: Container(
                              width: 250,
                              height: 100,
                              decoration:
                                  const BoxDecoration(color: Colors.black38),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'สถานที่ : ${appController.beeModels.last.name}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
        }),
      ),
      floatingActionButton: Row(
        children: [
          const SizedBox(
            width: 32,
          ),
          ElevatedButton(
            onPressed: () {
              if (appController.phoneNumbers.isEmpty) {
                //ยังไม่ได้ Save เบอร์โทร
                AppDialog(title: 'ยังไม่ได้ Save เบอร์โทร').normalDialog(
                    firstAction: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.to(const Setting());
                        },
                        child: const Text('Save เบอร์โทร')));
              } else {
                AppService().checkDistance().then((value) {
                  print('ใกล้สุด ---> ${appController.beeModels.last.toMap()}');

                  createMarker(
                      lat: double.parse(appController.beeModels.last.lat),
                      lng: double.parse(appController.beeModels.last.lng),
                      title: appController.beeModels.last.name);

                  show = true;

                  setState(() {});
                });
              }
            },
            child: const Text('Emergency Call'),
          ),
        ],
      ),
    );
  }
}
