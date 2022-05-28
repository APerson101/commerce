import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'amplifyconfiguration.dart';
import 'controllers/main_controller.dart';
import 'models/ModelProvider.dart';
import 'views/home.dart';
import 'views/signinview.dart';
import 'views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(AppDecider());
}

class AppDecider extends StatelessWidget {
  final MainController controller = Get.put(MainController());
  AppDecider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.userSignedIn(),
        builder: ((context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            bool status = snapshot.data!;
            if (status) {
              return MainLoader();
            } else {
              return MyApp();
            }
          }
          return const Scaffold(
            body: Center(child: Text('Unknown Error')),
          );
        }));
  }
}

class MyApp extends StatelessWidget {
  final RxBool _amplifyConfigured = false.obs;
  MyApp({Key? key}) : super(key: key) {
    initApp();
  }

  initApp() async {
    Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    Amplify.addPlugin(AmplifyAuthCognito());

    Amplify.configure(amplifyconfig);
    try {
      _amplifyConfigured.value = true;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
          switch (state.currentStep) {
            case AuthenticatorStep.signIn:
              return SignInView(authenticatorState: state);

            case AuthenticatorStep.signUp:
              return SignupFirstView(authenticatorState: state);
            default:
              return null;
          }
        },
        child: MainLoader());
  }
}

class MainLoader extends StatelessWidget {
  MainLoader({Key? key}) : super(key: key) {}
//  light theme
  final ThemeData customLightTheme = ThemeData(
    // app's colors scheme and brightness
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
    ),
    // tab bar indicator color
    indicatorColor: Colors.indigo,
    textTheme: const TextTheme(
      // text theme of the header on each step
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    ),
    // theme of the form fields for each step
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[200],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    // theme of the primary button for each step
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );

// dark theme
  final ThemeData customDarkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
    ),
    indicatorColor: Colors.indigo,
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[700],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: ThemeMode.system,
      builder: Authenticator.builder(),
      title: 'E commerce',
      home: Scaffold(body: HomePage()),
    );
  }
}
