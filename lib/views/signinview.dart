import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_authenticator/src/state/authenticator_state.dart';
import 'package:commerce/views/home.dart';
import 'package:commerce/views/signupview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                const Text("Sign In"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("To Continue using"),
                    FlutterLogo(size: 24),
                  ],
                ),
                SignInForm(),
              ]),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('New user?'),
            TextButton(
                onPressed: () {
                  authenticatorState
                      .changeStep(AuthenticatorStep.confirmSignUp);
                },
                child: const Text('Create Account'))
          ],
        )
      ],
    );
  }
}

/**
 *  SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: TextField(
            onChanged: (enteredEmail) => controller.email.value = enteredEmail,
            decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Obx(
            () => TextField(
                obscureText: controller.passwordview.value,
                onChanged: (enteredpassword) =>
                    controller.password.value = enteredpassword,
                decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () => controller.togglePasswordView(),
                        icon: const Icon(Icons.remove_red_eye_rounded)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
        ),
        Obx(() => CheckboxListTile(
            title: Text("As a service provider"),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.only(left: 50, right: 50),
            value: controller.asServiceProvider.value,
            onChanged: (newValue) =>
                controller.asServiceProvider.value = newValue!)),
        ElevatedButton(onPressed: () async {
          controller.signIn();
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          });
        }, child: Obx(() {
          if (controller.loadingstates.value == signInStates.loading) {
            return const CircularProgressIndicator.adaptive();
          } else {
            return const Text("SIGN IN ");
          }
        })),
        const Text('New user?'),
        ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpView())),
            child: Text("Create Account")),
        Row(
          children: [
            Expanded(child: Divider()),
            Text("or"),
            Expanded(child: Divider()),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: Text("SIGN IN WITH APPLE")),
        ElevatedButton(onPressed: () {}, child: Text("SIGN IN WITH GOOGLE")),
 */