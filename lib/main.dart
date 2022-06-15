import 'dart:typed_data';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/controllers/signupcontroller.dart';
import 'package:commerce/views/main_app_views/bookings_view.dart';
import 'package:commerce/views/main_app_views/dashboard_view.dart';
import 'package:commerce/views/main_app_views/profile_view.dart';
import 'package:commerce/views/main_app_views/search_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'amplifyconfiguration.dart';
import 'controllers/main_controller.dart';
import 'firebase_options.dart';
import 'models/ModelProvider.dart';
import 'splashscreen.dart';
import 'views/home.dart';
import 'views/sign_up_contd_view.dart';
import 'views/signinview.dart';
import 'views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final RxBool _amplifyConfigured = false.obs;

  initApp() async {
    await Amplify.addPlugin(
        AmplifyDataStore(modelProvider: ModelProvider.instance));
    await Amplify.addPlugin(AmplifyAuthCognito());
    // Amplify.DataStore.clear();
    await Amplify.addPlugin(AmplifyAPI());
    await Amplify.configure(amplifyconfig);
    try {
      _amplifyConfigured.value = true;
    } catch (e) {
      print({
        e,
      });
    }
  }

  await initApp();
  runApp(ProviderScope(child: MyApp()));
  // runApp(ProviderScope(child: GetMaterialApp(home: MyApp())));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Authenticator(
        authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
          switch (state.currentStep) {
            case AuthenticatorStep.signIn:
              return SignInView(authenticatorState: state);
            case AuthenticatorStep.loading:
              return const Scaffold(body: Center(child: SplashScreen()));
            case AuthenticatorStep.signUp:
              return SignupFirstView(authenticatorState: state);
            default:
              return null;
          }
        },
        child: GetMaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.red.shade800)),
            // theme: ThemeData.from(
            //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
            // ),
            builder: Authenticator.builder(),
            home: const MainLoader()));
  }
}

class MainLoader extends ConsumerWidget {
  const MainLoader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, dynamic>> newUser = ref.watch(newUserProvider);
    final signUpcomplete = ref.watch(signupProvider);
    return newUser.when(
        data: (status) {
          if (status.isNotEmpty) {
            print("user is not new");
            if (status['authUser'] != null) {
              print("user is authenitcated");

              Get.put(MainController(status['authUser'] as AuthUser));
            } else {
              print("Unauthenitcated");
              return MainP();
            }
            if (status['newUser']) {
              print("HERE 3");

              if (signUpcomplete) {
                print("HERE 2");

                return MainP();
              } else {
                print("HERE 1");
                print((status['authUser'] as AuthUser).userId);
                return SignUpContdView(
                    userId: (status['authUser'] as AuthUser).userId);
              }
            } else {
              print("HERE 4");

              return MainP();
            }
          } else {
            return const Scaffold(
                body: Center(
              child: SplashScreen(),
            ));
          }
        },
        loading: () {
          return const Scaffold(
              body: Center(
            child: SplashScreen(),
          ));
        },
        error: (error, lo) => const Scaffold(
            body: Center(child: Text("Omo, this Error Choke!!"))));
  }
}

class MainP extends StatelessWidget {
  MainP({Key? key}) : super(key: key);
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
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(primary: Colors.red.shade800),
      ),
      // darkTheme: customDarkTheme,
      // themeMode: ThemeMode.system,

      builder: Authenticator.builder(),
      title: 'E Commerce',
      home: Scaffold(body: HomePage()),
    );
  }
}

class ImageSender extends StatelessWidget {
  ImageSender({Key? key}) : super(key: key);
  List<Uint8List> files = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                List<XFile>? allFIiles = await ImagePicker().pickMultiImage();
                allFIiles?.forEach((element) async {
                  var file = await element.readAsBytes();
                  files.add(file);
                });
              },
              child: const Text("select images")),
          ElevatedButton(
              onPressed: () async {
                files.forEach((file) async {
                  FirebaseStorage.instance
                      .ref('Businesses/Hair Salon')
                      .child('image ${files.indexOf(file)}.png')
                      .putData(
                          file,
                          SettableMetadata(
                              contentType: 'image/png',
                              customMetadata: {'userID': '4421'}));
                });
              },
              child: const Text("Send"))
        ],
      )),
    );
  }
}
