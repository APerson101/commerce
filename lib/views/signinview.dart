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
                        const Text("To continue using",
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
                // ElevatedButton(
                //     onPressed: () {
                //       authenticatorState.changeStep(AuthenticatorStep.signIn);
                //     },
                //     child: const Text('Sign In')),
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
                        primary: Colors.red,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 45)),
                    child: const Text('Create Account')),
                // Row(
                //   children: const [
                //     Expanded(child: Divider()),
                //     Text("or"),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // SocialLoginButton(
                //   buttonType: SocialLoginButtonType.google,
                //   onPressed: () async {
                //     var res = await Amplify.Auth.signInWithWebUI(
                //         provider: AuthProvider.facebook);
                //   },
                // ),
              ]),
        ),
      ),
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