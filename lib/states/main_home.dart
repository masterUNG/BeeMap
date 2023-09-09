import 'package:beemap/states/app_new_appointment.dart';
import 'package:beemap/states/setting.dart';
import 'package:beemap/states/show_map.dart';
import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/widgets/widget_button.dart';
import 'package:beemap/widgets/widget_icon_button.dart';
import 'package:beemap/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: WidgetText(data: appController.datas[1]),
          actions: [
            WidgetIconButton(
              iconData: Icons.settings,
              pressFunc: () {
                Get.to(const Setting());
              },
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const WidgetText(data: 'Emergency :'),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WidgetButton(
                  label: 'Contact',
                  pressFunc: () {},
                ),
                WidgetButton(
                  label: 'Map',
                  pressFunc: () {
                    Get.to(const ShowMap());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const WidgetText(data: 'AppointMent :'),
            const SizedBox(
              height: 16,
            ),
            WidgetButton(
              label: 'Add AppointMent',
              pressFunc: () {
                Get.to(const AddNewAppointment());
              },
            )
          ],
        ),
      );
    });
  }
}
