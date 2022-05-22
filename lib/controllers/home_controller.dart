import 'package:get/get.dart';

import '../views/home.dart';

class HomeController extends GetxController {
  Rx<views> currentView = views.dashboard.obs;
}
