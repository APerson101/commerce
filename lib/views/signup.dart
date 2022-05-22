// ignore: implementation_imports
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signupcontroller.dart';

class SignupFirstView extends StatelessWidget {
  SignupFirstView({Key? key, required this.authenticatorState})
      : super(key: key);
  final AuthenticatorState authenticatorState;
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Obx(() => CheckboxListTile(
                      title: const Text("As service Provider"),
                      contentPadding: const EdgeInsets.all(30),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: controller.asServiceProvider.value,
                      onChanged: (newValue) {
                        controller.asServiceProvider.value = newValue!;
                        if (newValue) {
                          controller.name.value = "Business Name";
                        } else {
                          controller.name.value = "Full Name";
                        }
                      })),
                  SignUpForm(),
                ]))));
  }
}
