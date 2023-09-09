import 'package:beemap/utility/app_service.dart';
import 'package:beemap/widgets/widget_button.dart';
import 'package:beemap/widgets/widget_form.dart';
import 'package:beemap/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: WidgetForm(
                    textEditingController: nameController,
                    labelWidget: const WidgetText(data: 'Display Name :'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: WidgetForm(
                    textEditingController: userController,
                    labelWidget: const WidgetText(data: 'User :'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: WidgetForm(
                    textEditingController: passwordController,
                    labelWidget: const WidgetText(data: 'Password :'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: WidgetButton(
                    label: 'Create New Account',
                    pressFunc: () {
                      if ((nameController.text.isEmpty) ||
                          (userController.text.isEmpty) ||
                          (passwordController.text.isEmpty)) {
                        Get.snackbar('Have Space', 'Please Fill Every Blank',
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        AppService().processCreateNewAccount(
                            name: nameController.text,
                            user: userController.text,
                            password: passwordController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
