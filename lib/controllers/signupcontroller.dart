import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';

import 'package:commerce/models/ModelProvider.dart';

import '../views/sign_up_contd_view.dart';

class DayTimeHelper {
  DateTime startTime;
  DateTime endTime;
  DayTimeHelper({
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() {
    return '${startTime.toString()} - ${endTime.toString()}';
  }
}

final signupProvider = StateProvider<bool>((ref) => false);

enum SignupcompletionState { done, inprogress }

class SignUpController extends GetxController {
  RxString selectedCountry = 'select country'.obs;
  RxString location = ''.obs;
  RxString phonenumber = ''.obs;
  RxInt selectedBusinessType = 0.obs;
  RxList<int> selectedDays = <int>[].obs;

  RxString countryTextToDisplay = 'select country'.obs;

  RxString fullname = "".obs;

  RxString countryNumbercode = ''.obs;

  RxBool passwordview = true.obs;

  RxString enteredpassword = ''.obs;
  RxString name = "Full Name".obs;

  RxBool asServiceProvider = false.obs;
  RxBool showHrs = false.obs;
  RxList<File> selectedImageFiles = <File>[].obs;
  RxMap<DaysWeek, DayTimeHelper> dayTimeMapping2 =
      <DaysWeek, DayTimeHelper>{}.obs;
  Rx<signUpStates> currentState = signUpStates.idle.obs;
  RxString cac = ''.obs;
  RxString aboutBusiness = ''.obs;

  Future signUp(String userId) async {
    currentState.value = signUpStates.loading;
    //save to db
    List<String> imagePaths = [];
    'Users/$userId';
    await Amplify.DataStore.save<Users>(Users(
      name: fullname.value,
      id: userId,
      number: phonenumber.value,
      country: selectedCountry.value,
      cac: cac.value,
      pics: imagePaths,
      isBusiness: asServiceProvider.value,
    ));
    if (asServiceProvider.value) {
      var businesses = [
        'Hair Salon',
        'Barbing Salon',
        'Driving School',
        'Nail Salon'
      ];
      String selectedBusiness = businesses[selectedBusinessType.value];
      await Amplify.DataStore.save<Businesses>(Businesses(
          id: userId,
          type: selectedBusiness,
          location: location.value,
          about: aboutBusiness.value,
          AvailableDays: selectedDays,
          availableTimes:
              dayTimeMapping2.values.map((e) => e.toString()).toList()));
      //save all uploaded images
      FirebaseStorage instance = FirebaseStorage.instance;

      for (var i = 0; i < selectedImageFiles.length; i++) {
        instance.ref('Businesses/$selectedBusiness').putData(
            selectedImageFiles[i].readAsBytesSync(),
            SettableMetadata(
              customMetadata: {
                'userID': userId,
                'category': selectedBusiness,
              },
            ));
      }
    }
    currentState.value = signUpStates.success;
  }
}

enum signUpStates { loading, failure, idle, success }
