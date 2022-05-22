import 'package:get/get.dart';

enum currentSearchState { idle, searching, none, error, done }

class SearchController extends GetxController {
  //
  Rx<currentSearchState> currentState = currentSearchState.idle.obs;
}
