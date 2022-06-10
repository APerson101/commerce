import 'package:get/get.dart';

class SignInController extends GetxController {
  RxString email = ''.obs;

  RxBool passwordview = true.obs;

  RxString password = ''.obs;

  RxBool asServiceProvider = true.obs;

  Rx<signInStates> loadingstates = signInStates.idle.obs;

  togglePasswordView() {
    if (passwordview.value) {
      passwordview.value = false;
    } else {
      passwordview.value = true;
    }
  }

  void signIn() {
    loadingstates.value = signInStates.loading;
  }
}

enum signInStates { loading, failed, success, idle }
