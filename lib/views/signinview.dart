// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_authenticator/src/state/authenticator_state.dart';
// import 'package:commerce/views/home.dart';
// import 'package:commerce/views/signupview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/signincontroller.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key, required this.authenticatorState}) : super(key: key);
  AuthenticatorState authenticatorState;
  SignInController controller = Get.put(SignInController());

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
                const SizedBox(height: 10),
                ListTile(
                  title: const Center(
                      child: Text(
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("To continue using   ",
                            style: TextStyle(
                              fontSize: 22,
                            )),
                        Image.asset('assets/images/logo.jpeg',
                            width: 100, height: 100)
                      ]),
                ),
                SignInForm.custom(
                  fields: [
                    SignInFormField.username(),
                    SignInFormField.password(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => CheckboxListTile(
                    title: const Text("As a service provider"),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.only(left: 50, right: 50),
                    value: controller.asServiceProvider.value,
                    onChanged: (newValue) async {
                      controller.asServiceProvider.value = newValue!;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool(
                          'isBusiness', controller.asServiceProvider.value);
                    })),
                const SizedBox(
                  height: 25,
                ),
                const Text('New user?'),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      authenticatorState.changeStep(AuthenticatorStep.signUp);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 45)),
                    child: const Text('Create Account')),
              ]),
        ),
      ),
    );
  }
}
