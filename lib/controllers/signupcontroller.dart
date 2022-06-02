import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';

final signupProvider = StateProvider<bool>((ref) => false);

enum SignupcompletionState { done, inprogress }

class SignUpController extends GetxController {
  RxString selectedCountry = ''.obs;
  RxString location = ''.obs;
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

  Rx<signUpStates> currentState = signUpStates.idle.obs;

  RxString aboutBusiness = ''.obs;

  Future signUp(String userId) async {
    currentState.value = signUpStates.loading;
    //save to db
    await Amplify.DataStore.save<Users>(Users(
      name: fullname.value,
      id: userId,
      isBusiness: asServiceProvider.value,
    ));
    if (asServiceProvider.value) {
      await Amplify.DataStore.save<Businesses>(Businesses(
        id: userId,
        type: 'selectedBusinessType.value',
        location: location.value,
        about: aboutBusiness.value,
      ));
      //save all uploaded images
      FirebaseStorage instance = FirebaseStorage.instance;
      var businesses = [
        'Hair Salon',
        'Barbing Salon',
        'Driving School',
        'Nail Salon'
      ];
      String selectedBusiness = businesses[selectedBusinessType.value];

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
