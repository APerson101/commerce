import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/controllers/signupcontroller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'amplifyconfiguration.dart';
import 'controllers/main_controller.dart';
import 'firebase_options.dart';
import 'models/ModelProvider.dart';
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

    await Amplify.addPlugin(AmplifyAPI());
    await Amplify.configure(amplifyconfig);
    try {
      _amplifyConfigured.value = true;
    } catch (e) {
      print(e);
    }
  }

  await initApp();
  runApp(ProviderScope(child: GetMaterialApp(home: MyApp())));
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
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator.adaptive()));
            case AuthenticatorStep.signUp:
              return SignupFirstView(authenticatorState: state);
            default:
              return null;
          }
        },
        child: const MainLoader());
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
          Get.put(MainController(status['authUser'] as AuthUser));
          if (status['newUser']) {
            if (signUpcomplete) {
              return MainP();
            } else {
              return SignUpContdView(
                  userId: (status['authUser'] as AuthUser).userId);
            }
          } else {
            return MainP();
          }
        },
        loading: () {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator.adaptive(),
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
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      themeMode: ThemeMode.system,
      builder: Authenticator.builder(),
      title: 'E commerce',
      home: Scaffold(body: HomePage()),
    );
  }
}
