import 'package:beemap/states/create_new_account.dart';
import 'package:beemap/utility/app_constant.dart';
import 'package:beemap/utility/app_controller.dart';
import 'package:beemap/utility/app_dialog.dart';
import 'package:beemap/utility/app_service.dart';
import 'package:beemap/widgets/widget_button.dart';
import 'package:beemap/widgets/widget_form.dart';
import 'package:beemap/widgets/widget_text.dart';
import 'package:beemap/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetForm(
                    textEditingController: userController,
                    hint: 'User :',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  WidgetForm(
                    textEditingController: passwordController,
                    hint: 'Password :',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 250,
                    child: WidgetButton(
                      label: 'Login',
                      pressFunc: () {
                        if ((userController.text.isEmail) ||
                            (passwordController.text.isEmpty)) {
                          Get.snackbar('Have Spave', 'Please Fill EveryBlank');
                        } else {
                          AppService().checkLogin(user: userController.text, password: passwordController.text);
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const WidgetText(data: 'WithOut Account? '),
                      WidgetTextButton(
                        label: 'Create Account',
                        pressFunc: () {
                          AppDialog(title: 'Policy Argument').normalDialog(
                            secondAction: Obx(() {
                              return appController.accept.value
                                  ? WidgetTextButton(
                                      label: 'Accept',
                                      pressFunc: () {
                                        appController.accept.value = false;
                                        Get.back();
                                        Get.to(const CreateNewAccount());
                                      },
                                    )
                                  : const SizedBox();
                            }),
                            contentWidget: Obx(() {
                              return Column(
                                children: [
                                  WidgetText(data: AppConstant.termOfCondition),
                                  CheckboxListTile(
                                    value: appController.accept.value,
                                    onChanged: (value) {
                                      appController.accept.value = value!;
                                    },
                                    title: const WidgetText(
                                        data: 'ยอมรับเงื่อนไข'),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
