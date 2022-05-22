import 'dart:ffi';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  //
  AuthUser? user;
  bool isUserBusiness = false;

  MainController() {
    getUserDetails();
  }

  init() async {}

  Future<bool> userSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  getUserDetails() async {
    //
    var pref = await SharedPreferences.getInstance();
    isUserBusiness = pref.getBool('isUserBusiness') ?? false;
  }

  getUserType() {
    return isUserBusiness;
  }

  loadUser() async {
    user = await Amplify.Auth.getCurrentUser();
  }

  getuser() {
    return user;
  }

  setUserType(bool type) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('isUserBusiness', type);
  }
}
