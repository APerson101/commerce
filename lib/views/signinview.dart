// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_authenticator/src/state/authenticator_state.dart';
// import 'package:commerce/views/home.dart';
// import 'package:commerce/views/signupview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

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
                ListTile(
                  title: const Text(
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Row(children: const [
                    Text("To continue using"),
                    FlutterLogo()
                  ]),
                ),
                SignInForm.custom(
                  fields: [
                    SignInFormField.username(),
                    SignInFormField.password(),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      authenticatorState.changeStep(AuthenticatorStep.signIn);
                    },
                    child: const Text('Sign In')),
                Obx(() => CheckboxListTile(
                    title: const Text("As a service provider"),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.only(left: 50, right: 50),
                    value: controller.asServiceProvider.value,
                    onChanged: (newValue) =>
                        controller.asServiceProvider.value = newValue!)),
                const Text('New user?'),
                ElevatedButton(
                    onPressed: () {
                      authenticatorState.changeStep(AuthenticatorStep.signUp);
                    },
                    child: const Text('Create Account')),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Text("or"),
                    Expanded(child: Divider()),
                  ],
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () async {
                    var res = await Amplify.Auth.signInWithWebUI(
                        provider: AuthProvider.facebook);
                  },
                ),
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