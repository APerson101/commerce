import 'dart:io';

import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxString selectedCountry = ''.obs;
  RxString location = ''.obs;

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

  RxString phoneText = "NG".obs;
  togglePasswordView() {
    if (passwordview.value) {
      passwordview.value = false;
    } else {
      passwordview.value = true;
    }
  }

  void signUp() {
    currentState.value = signUpStates.loading;
  }
}

enum signUpStates { loading, failure, idle, success }
