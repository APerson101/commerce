import 'package:get/get.dart';

enum editOptions { name, bank, email, number }
enum businessEditOptions { about, images, location }

class ProfileController extends GetxController {
  String name = 'Test Name';
  String bank = 'Test Bank';
  String email = 'Test Email@gmail.com';
  String number = '081234567890';
  RxBool isEditingName = false.obs;
  RxBool isEditingbank = false.obs;
  RxBool isEditingEmail = false.obs;
  RxBool isEditingNumber = false.obs;

  RxString newName = ''.obs;
  RxString newBank = ''.obs;
  RxString newEmail = ''.obs;
  RxString newNumber = ''.obs;

// Business stuffs
  String about = 'default ABout';
  String location = 'default Location';

  RxBool isEditingAbout = false.obs;
  RxBool isEditingLocation = false.obs;

  RxString newAbout = ''.obs;
  RxString newLocation = ''.obs;
}
