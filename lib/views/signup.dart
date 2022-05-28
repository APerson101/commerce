// ignore: implementation_imports
import 'dart:io';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';

import '../controllers/signupcontroller.dart';

class SignupFirstView extends StatelessWidget {
  SignupFirstView({Key? key, required this.authenticatorState})
      : super(key: key);
  final AuthenticatorState authenticatorState;
  final SignUpController controller = Get.put(SignUpController());

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
                  Obx(() => CheckboxListTile(
                      title: const Text("As service Provider"),
                      contentPadding: const EdgeInsets.all(30),
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
                  //add the rest of the things
                  // images, availability, about, etc.
                  Obx(() => controller.asServiceProvider.value
                      ? availability()
                      : Container()),
                  Obx(() => controller.asServiceProvider.value
                      ? images(context)
                      : Container()),
                  Obx(() => controller.asServiceProvider.value
                      ? locationAbout(context)
                      : Container()),
                  SignUpForm(),
                  SignUpForm(),
                ]))));
  }

  Widget availability() {
    /**
     * dislay the days and time accordingly
     */
    List<S2Choice<int>> days_of_the_week = [
      S2Choice<int>(value: 1, title: 'Sunday'),
      S2Choice<int>(value: 2, title: 'Monday'),
      S2Choice<int>(value: 3, title: 'Tuesday'),
      S2Choice<int>(value: 4, title: 'Wednesday'),
      S2Choice<int>(value: 5, title: 'Thursday'),
      S2Choice<int>(value: 6, title: 'Friday'),
      S2Choice<int>(value: 7, title: 'Saturday'),
    ];

    List<Map<String, String>> days = [
      {'value': 'mon', 'title': 'Monday'},
      {'value': 'tue', 'title': 'Tuesday'},
      {'value': 'wed', 'title': 'Wednesday'},
      {'value': 'thu', 'title': 'Thursday'},
      {'value': 'fri', 'title': 'Friday'},
      {'value': 'sat', 'title': 'Saturday'},
      {'value': 'sun', 'title': 'Sunday'},
    ];
    List<Map<String, String>> hrs = [
      {'value': '1', 'title': '08:00AM - 09:00AM'},
      {'value': '2', 'title': '09:00AM - 10:00AM'},
      {'value': '3', 'title': '10:00AM - 11:00AM'},
      {'value': '4', 'title': '11:00AM - 12:00 Noon'},
      {'value': '5', 'title': '12:00 Noon-1:00PM'},
      {'value': '6', 'title': '1:00PM - 2:00PM'},
      {'value': '7', 'title': '2:00PM - 3:00PM'},
      {'value': '8', 'title': '3:00PM - 4:00PM'},
      {'value': '9', 'title': '4:00PM - 5:00PM'},
      {'value': '10', 'title': '5:00PM - 6:00PM'},
      {'value': '11', 'title': '6:00PM - 7:00PM'},
      {'value': '12', 'title': '7:00PM - 8:00PM'},
      {'value': '13', 'title': '8:00PM - 9:00PM'},
      {'value': '14', 'title': '9:00PM - 10:00PM'},
      {'value': '15', 'title': '10:00PM - 11:00PM'},
      {'value': '16', 'title': '11:00PM - 12:00AM'},
      {'value': '17', 'title': '12:00AM - 01:00AM'},
      {'value': '18', 'title': '1:00AM - 2:00AM'},
      {'value': '19', 'title': '2:00AM - 3:00AM'},
      {'value': '20', 'title': '3:00AM - 4:00AM'},
      {'value': '21', 'title': '4:00AM - 5:00AM'},
      {'value': '22', 'title': '5:00AM - 6:00AM'},
      {'value': '23', 'title': '6:00AM - 7:00AM'},
      {'value': '24', 'title': '7:00AM - 8:00AM'},
    ];
    return Obx(() => controller.showHrs.value
        ? SingleChildScrollView(
            child: Column(children: [
            SmartSelect.multiple(
              value: days_of_the_week,
              onChange: (selected) {},
              placeholder: 'select all days for availability',
              title: "Days of the week",
              choiceItems: S2Choice.listFrom(
                  source: days,
                  value: (index, Map<String, String> item) => item['value'],
                  title: (index, Map<String, String> item) => item['title']),
            ),
            ButtonBar(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      controller.showHrs.value = true;
                    },
                    child: const Text("Continue")),
              ],
            )
          ]))
        : SmartSelect.multiple(
            value: days_of_the_week,
            onChange: (selected) {},
            placeholder: 'select all days for availability',
            title: "Hrs of the day",
            choiceItems: S2Choice.listFrom(
                source: hrs,
                value: (index, Map<String, String> item) => item['value'],
                title: (index, Map<String, String> item) => item['title']),
          ));
  }

  Widget images(BuildContext context) {
    return Obx(() {
      if (controller.selectedImageFiles.isEmpty) {
        return ElevatedButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final List<XFile>? images = await _picker.pickMultiImage();
              images?.forEach((image) {
                controller.selectedImageFiles.add(File(image.path));
              });
            },
            child: const Text("select Images"));
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: controller.selectedImageFiles
                    .map((imagefile) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.file(imagefile),
                        ))
                    .toList()),
          ),
        );
      }
    });
  }

  Widget locationAbout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextField(
            onChanged: (newLocation) => controller.location.value = newLocation,
            decoration: const InputDecoration(
                hintText: "Enter Location", border: OutlineInputBorder()),
          ),
        )
      ],
    );
  }
}
