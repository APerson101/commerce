import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signupcontroller.dart';

class SignupFirstView extends StatelessWidget {
  SignupFirstView({Key? key, required this.authenticatorState})
      : super(key: key);
  final SignUpController controller = Get.put(SignUpController());

  final AuthenticatorState authenticatorState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.red.sh,
          leading: IconButton(
              onPressed: () =>
                  authenticatorState.changeStep(AuthenticatorStep.signIn),
              icon: const Icon(Icons.keyboard_backspace)),
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 48, bottom: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Image.asset('assets/images/logo.jpeg',
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.6),
                  SignUpForm()
                ]))));
  }
}
