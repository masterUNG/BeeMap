import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/widgets/widget_icon_button.dart';
import 'package:beemap/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAppointment extends StatefulWidget {
  const AddNewAppointment({super.key});

  @override
  State<AddNewAppointment> createState() => _AddNewAppointmentState();
}

class _AddNewAppointmentState extends State<AddNewAppointment> {
  DateTime nowDateTime = DateTime.now();

  TimeOfDay timeOfDay = TimeOfDay.now();

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    if (appController.chooseDateTimes.isNotEmpty) {
      appController.chooseDateTimes.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                return appController.chooseDateTimes.isEmpty
                    ? const WidgetText(data: 'วันนัดหมาย')
                    : WidgetText(
                        data: appController.chooseDateTimes.last.toString());
              }),
              WidgetIconButton(
                iconData: Icons.calendar_month,
                pressFunc: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: nowDateTime,
                          firstDate: DateTime(nowDateTime.year - 1),
                          lastDate: DateTime(nowDateTime.year + 1))
                      .then((value) {
                    appController.chooseDateTimes.add(value ?? nowDateTime);
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                return appController.chooseTimeOfDays.isEmpty
                    ? const WidgetText(data: 'HH mm')
                    : WidgetText(data: appController.chooseTimeOfDays.last.toString());
              }),
              WidgetIconButton(
                iconData: Icons.timer,
                pressFunc: () async {
                  await showTimePicker(context: context, initialTime: timeOfDay)
                      .then((value) {
                    appController.chooseTimeOfDays.add(value ?? timeOfDay);
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
