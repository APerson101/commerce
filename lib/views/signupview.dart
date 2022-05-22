import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signupcontroller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key, required this.authenticatorState}) : super(key: key);
  SignUpController controller = Get.put(SignUpController());
  AuthenticatorState authenticatorState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Obx(() => CheckboxListTile(
                      title: const Text("As service Provider"),
                      contentPadding: EdgeInsets.all(30),
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
                  SignUpForm.custom(fields: [
                    SignUpFormField.phoneNumber(),
                    SignUpFormField.email(required: true),
                    SignUpFormField.username(),
                    SignUpFormField.password(),
                    SignUpFormField.passwordConfirmation(),
                    SignUpFormField.custom(
                        title: 'Country',
                        required: true,
                        attributeKey:
                            const CognitoUserAttributeKey.custom('Country')),
                    SignUpFormField.custom(
                        title: 'CAC Number',
                        hintText: 'For businesses Only',
                        attributeKey:
                            const CognitoUserAttributeKey.custom('CAC'))
                  ]),
                  /*
                  //   ElevatedButton(
                  //       onPressed: () {
                  //         showCountryPicker(
                  //             showPhoneCode: false,
                  //             context: context,
                  //             onSelect: (selectedCountry) {
                  //               controller.countryTextToDisplay.value =
                  //                   selectedCountry.displayNameNoCountryCode;
                  //               controller.selectedCountry.value =
                  //                   selectedCountry.displayNameNoCountryCode;
                  //             });
                  //       },
                  //       child: Obx(
                  //           () => Text(controller.countryTextToDisplay.value))),
                  //   SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.8,
                  //     child: Obx(() {
                  //       String text = controller.name.value;
                  //       return TextFormField(
                  //         onChanged: (enteredText) =>
                  //             controller.fullname.value = enteredText,
                  //         decoration: InputDecoration(
                  //             hintText: text,
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(20))),
                  //       );
                  //     }),
                  //   ),
                  //   Obx(() {
                  //     return controller.asServiceProvider.value
                  //         ? SizedBox(
                  //             width: MediaQuery.of(context).size.width * 0.8,
                  //             child: TextFormField(
                  //               onChanged: (enteredText) =>
                  //                   controller.fullname.value = enteredText,
                  //               decoration: InputDecoration(
                  //                   hintText: "CAC reg. No (Optional)",
                  //                   border: OutlineInputBorder(
                  //                       borderRadius:
                  //                           BorderRadius.circular(20))),
                  //             ),
                  //           )
                  //         : Container();
                  //   }),
                  //   SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.8,
                  //       child: TextFormField(
                  //         onChanged: (enteredText) =>
                  //             controller.fullname.value = enteredText,
                  //         decoration: InputDecoration(
                  //             hintText: "Phone Number (Optional)",
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(20))),
                  //       )),
                  //   SizedBox(
                  //     width: MediaQuery.of(context).size.width * .8,
                  //     child: Obx(
                  //       () => SizedBox(
                  //           width: MediaQuery.of(context).size.width * 0.8,
                  //           child: TextFormField(
                  //               obscureText: controller.passwordview.value,
                  //               onChanged: (enteredpassword) => controller
                  //                   .enteredpassword.value = enteredpassword,
                  //               decoration: InputDecoration(
                  //                   prefixIcon: IconButton(
                  //                       onPressed: () {
                  //                         showCountryPicker(
                  //                             context: context,
                  //                             showPhoneCode: true,
                  //                             onSelect: (countryNumbercode) {
                  //                               controller.countryNumbercode
                  //                                       .value =
                  //                                   countryNumbercode.phoneCode;
                  //                               controller.phoneText.value =
                  //                                   countryNumbercode.phoneCode;
                  //                             });
                  //                       },
                  //                       icon: Obx(() =>
                  //                           Text(controller.phoneText.value))),
                  //                   helperText: "Password",
                  //                   suffixIcon: IconButton(
                  //                       onPressed: () =>
                  //                           controller.togglePasswordView(),
                  //                       icon: const Icon(
                  //                           Icons.remove_red_eye_rounded)),
                  //                   border: OutlineInputBorder(
                  //                       borderRadius:
                  //                           BorderRadius.circular(20))))),
                  //     ),
                  //   ),
                  //   ElevatedButton(onPressed: () async {
                  //     controller.signUp();
                  //   }, child: Obx(() {
                  //     if (controller.currentState.value ==
                  //         signUpStates.loading) {
                  //       return const CircularProgressIndicator.adaptive();
                  //     } else {
                  //       return const Text("CREATE ACCOUNT");
                  //     }
                  //   })),
                  //   const Text('Already have an account? Sign in'),
                  //   ElevatedButton(
                  //       onPressed: () => Navigator.of(context).push(
                  //           MaterialPageRoute(
                  //               builder: (context) => SignInView())),
                  //       child: Text("SIGN IN")),
                  //   Row(
                  //     children: [
                  //       Expanded(child: Divider()),
                  //       Text("or"),
                  //       Expanded(child: Divider()),
                  //     ],
                  //   ),
                  //   ElevatedButton(
                  //       onPressed: () {}, child: Text("SIGN IN WITH APPLE")),
                  //   ElevatedButton(
                  //       onPressed: () {}, child: Text("SIGN IN WITH GOOGLE")),
                  // ]),

                  */
                ]))),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: () => authenticatorState.changeStep(
                  AuthenticatorStep.signIn,
                ),
                child: const Text('Sign In'),
              ),
            ],
          ),
        ]);
  }
}
