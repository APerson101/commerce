import 'dart:io';
import 'package:awesome_select/awesome_select.dart';
import 'package:commerce/controllers/signincontroller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../controllers/signupcontroller.dart';
// import '../main.dart';

class SignUpContdView extends ConsumerWidget {
  SignUpContdView({Key? key, required this.userId}) : super(key: key);
  final String userId;
  final SignUpController controller = Get.put(SignUpController());
  final SignInController controller_ = Get.put(SignInController());
  // final SignInController controller_ = Get.find();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ObxValue((Rx<signUpStates> current) {
      switch (current.value) {
        case signUpStates.loading:
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        case signUpStates.failure:
          return const Scaffold(
            body: Center(child: Text("Unknown Error")),
          );
        case signUpStates.success:
          return Scaffold(
              body: Center(
                  child: SafeArea(
            child: Column(children: [
              const Spacer(),
              const Text("Sign Up successful"),
              ElevatedButton(
                  onPressed: () {
                    ref.read(signupProvider.notifier).state = true;
                  },
                  child: const Text("Continue")),
              const Spacer(),
            ]),
          )));
        case signUpStates.idle:
          return signUpSheet(context);
        default:
          return Container();
      }
    }, controller.currentState);
  }

  Scaffold signUpSheet(BuildContext context) {
    controller_.asServiceProvider.value
        ? controller.name.value = "Business Name"
        : controller.name.value = "Full Name";

    return Scaffold(
        appBar: AppBar(
          title: Image.asset('images/logo.jpeg'),
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: Row(children: const [
                      Text("Create Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Spacer()
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: Obx(() => OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.75, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (country_) {
                                  controller.selectedCountry.value =
                                      country_.displayNameNoCountryCode;
                                });
                          },
                          child: Row(children: [
                            Text(controller.selectedCountry.value),
                            Spacer()
                          ]),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: TextField(
                      onChanged: (number) =>
                          controller.phonenumber.value = number,
                      decoration: InputDecoration(
                          hintText: 'Phone Number (Optional)',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: Obx(() => TextField(
                        decoration: InputDecoration(
                            hintText: controller.name.value,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        onChanged: (newValue) {
                          controller.fullname.value = newValue;
                        })),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                    child: Obx(() => controller_.asServiceProvider.value
                        // ? teste(context)
                        ? availability(context)
                        : Container()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: images(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: Obx(() => controller_.asServiceProvider.value
                        ? locationAbout(context)
                        : Container()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: signUpButton(context),
                  )
                ]))));
  }

  Widget signUpButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width * 0.75, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () async {
          await controller.signUp(userId);
        },
        child: const Text("Create Account"));
  }

  Widget availability(BuildContext context) {
    /**
     * display the days and time accordingly
     */
    List<S2Choice<int>> days_of_the_week = [
      S2Choice<int>(value: 0, title: 'Sunday'),
      S2Choice<int>(value: 1, title: 'Monday'),
      S2Choice<int>(value: 2, title: 'Tuesday'),
      S2Choice<int>(value: 3, title: 'Wednesday'),
      S2Choice<int>(value: 4, title: 'Thursday'),
      S2Choice<int>(value: 5, title: 'Friday'),
      S2Choice<int>(value: 6, title: 'Saturday'),
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
    return Obx(() => !controller.showHrs.value
        ? SingleChildScrollView(
            child: Column(children: [
            SmartSelect.multiple(
              selectedValue: controller.selectedDays,
              onChange: (selected) {
                controller.selectedDays.value = selected!.value as List<int>;
              },
              placeholder: 'select all days for availability',
              title: "Days of the week",
              choiceItems: days_of_the_week,
            ),
            ButtonBar(
              children: [
                Spacer(),
                ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      controller.showHrs.value = true;
                    },
                    child: const Text("Continue")),
                Spacer()
              ],
            )
          ]))
        : dayTimePicker(context));
  }

  Widget dayTimePicker(BuildContext context) {
    RxList<DaysWeek> dayTimeMapping = <DaysWeek>[].obs;
    controller.selectedDays.forEach((element) {
      dayTimeMapping.add(DaysWeek.values[element]);
    });
    return SingleChildScrollView(
        child: Column(
            children: dayTimeMapping.map((day) {
      return ListTile(
        title: Text(
          describeEnum(day).capitalizeFirst!,
        ),
        subtitle: Obx(() {
          return controller.dayTimeMapping2[day] == null
              ? ListTile(
                  title: const Text("Add New Time"),
                  trailing: IconButton(
                      onPressed: () async {
                        TimeRange result = await showTimeRangePicker(
                          context: context,
                          interval: const Duration(minutes: 30),
                        );
                        controller.dayTimeMapping2[day] = DayTimeHelper(
                            startTime: DateTime(0, 1, 1, result.startTime.hour,
                                result.startTime.minute),
                            endTime: DateTime(0, 1, 1, result.endTime.hour,
                                result.endTime.minute));
                      },
                      icon: const Icon(Icons.add)),
                )
              : ListTile(
                  title: Text(controller.dayTimeMapping2[day].toString()),
                  trailing: IconButton(
                      onPressed: () {
                        controller.dayTimeMapping2.remove(day);
                      },
                      icon: const Icon(Icons.cancel)));
        }),
      );
    }).toList())
        // )
        );
  }

  Widget images(BuildContext context) {
    return Obx(() {
      if (controller.selectedImageFiles.isEmpty) {
        String text = controller_.asServiceProvider.value
            ? 'Select Images'
            : 'Select Profile Pic';
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.75, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final List<XFile>? images = controller_.asServiceProvider.value
                  ? await _picker.pickMultiImage()
                  : List<XFile>.from(
                      [await _picker.pickImage(source: ImageSource.gallery)]);

              images?.forEach((image) {
                controller.selectedImageFiles.add(File(image.path));
              });
            },
            child: Text(text));
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    controller.selectedImageFiles.clear();
                  },
                  icon: const Icon(Icons.cancel)),
              ...controller.selectedImageFiles
                  .map((imagefile) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.file(imagefile),
                      ))
                  .toList()
            ]),
          ),
        );
      }
    });
  }

  Widget locationAbout(BuildContext context) {
    List<S2Choice<int>> businessOptions = [
      S2Choice<int>(value: 0, title: 'Hair Salon'),
      S2Choice<int>(value: 1, title: 'Barbing Salon'),
      S2Choice<int>(value: 2, title: 'Driving School'),
      S2Choice<int>(value: 3, title: 'Farm'),
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onChanged: (cac) => controller.cac.value = cac,
              decoration: InputDecoration(
                  hintText: "Enter CAC",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onChanged: (newLocation) =>
                  controller.location.value = newLocation,
              decoration: InputDecoration(
                  hintText: "Enter Location",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onChanged: (newLocation) =>
                  controller.aboutBusiness.value = newLocation,
              decoration: InputDecoration(
                  hintText: "What's the businesss about?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Obx(() => SmartSelect.single(
            selectedValue: controller.selectedBusinessType.value,
            title: "Select Business Type",
            onChange: (selected) => controller.selectedBusinessType.value =
                int.parse(selected.value.toString()),
            choiceItems: businessOptions))
      ],
    );
  }
}

enum DaysWeek { sunday, monday, tuesday, wednesday, thursday, friday, saturday }
