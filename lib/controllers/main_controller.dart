import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class IsNewUser extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoggedOut extends LoginState {
  @override
  List<Object?> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object?> get props => [];
}

enum LoginStates { loggedOut, newUser, loggedIn, loading }

final FutureProvider<Map<String, dynamic>> newUserProvider =
    FutureProvider((ref) async {
  bool newuser = false;
  List<Users> users = [];
  AuthUser? authenticatedUser;
  return await ref.watch(loadUserProvider).when(data: (data) async {
    authenticatedUser = data;
    users = await Amplify.DataStore.query(Users.classType,
        where: Users.ID.eq(data.userId));
    newuser = users.isEmpty;
    return {'newUser': newuser, 'authUser': authenticatedUser};
  }, error: (error, e) {
    return {};
  }, loading: () {
    return {};
  });
  print({'newUser': newuser, 'authUser': authenticatedUser});
});

final userSignedInProvider = FutureProvider((ref) async {
  final result = await Amplify.Auth.fetchAuthSession();
  return result.isSignedIn;
});

final loadUserProvider = FutureProvider((ref) async {
  return await Amplify.Auth.getCurrentUser();
});

class MainController extends GetxController {
  AuthUser user;
  bool isUserBusiness = false;
  RxBool isSignUp = false.obs;
  Rx<LoadingStatus> status = LoadingStatus.loading.obs;

  MainController(this.user);

  loadDetails() async {
    await getUserDetails();
    await loadUser();
    await isNewUser();
  }

  Future<bool> userSignedIn() async {
    print('Attempting to get user results');
    final result = await Amplify.Auth.fetchAuthSession();
    print(result.isSignedIn);
    return result.isSignedIn;
  }

  getUserDetails() async {
    var pref = await SharedPreferences.getInstance();
    isUserBusiness = pref.getBool('isUserBusiness') ?? false;
    print({'loading status', isUserBusiness});
  }

  getActiveUser() async {
    user = await Amplify.Auth.getCurrentUser();
  }

  getUserType() {
    return isUserBusiness;
  }

  loadUser() async {
    if (await userSignedIn() == true) {
      user = await Amplify.Auth.getCurrentUser();
      print({'user is signed in: ', user.userId});
    } else {
      status.value = LoadingStatus.success;
    }
  }

  AuthUser? getUser() => user;

  setUserType(bool type) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('isUserBusiness', type);
  }

  isNewUser() async {
    if (user == null) {
      print("User is null. cant proceed");
      status.value = LoadingStatus.success;
      return;
    } else {
      try {
        status.value = LoadingStatus.success;
        print({'New user status: ', isnewuser.value});
      } catch (e) {
        status.value = LoadingStatus.failure;
        print(e);
      }
    }
  }

  RxBool isnewuser = false.obs;
}

enum LoadingStatus { loading, success, failure }
