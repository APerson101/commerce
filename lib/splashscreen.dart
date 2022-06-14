import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: const Color.fromARGB(255, 157, 41, 39),
        child: Column(children: [
          Center(
              child: Image.asset('assets/images/logo.jpeg',
                  width: MediaQuery.of(context).size.width * 0.7, height: 250)),
          const Spacer(),
          const CircularProgressIndicator.adaptive(),
          const Spacer()
        ]));
  }
}
