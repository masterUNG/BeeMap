import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/utility/app_dialog.dart';
import 'package:beemap/utility/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController textEditingController = TextEditingController();

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().findPhoneNumber().then((value) {
      if (appController.phoneNumbers.isNotEmpty) {
        textEditingController.text = appController.phoneNumbers.last;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Emergency Call Number:'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty) {
                      AppDialog(title: 'ยังไม่กรอกเบอร์โทรศัพย์')
                          .normalDialog();
                    } else {
                      GetStorage getStorage = GetStorage();
                      getStorage
                          .write('phoneNumber', textEditingController.text)
                          .then((value) {
                        Get.back();
                      });
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
