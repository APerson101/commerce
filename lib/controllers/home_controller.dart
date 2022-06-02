import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:get/get.dart';

import '../views/home.dart';

class HomeController extends GetxController {
  Rx<views> currentView = views.dashboard.obs;
  RxList<Bookings> unfulfilledBookings = <Bookings>[].obs;

  HomeController() {
    getNotifications();
  }
  getNotifications() async {
    unfulfilledBookings.value = await Amplify.DataStore.query(
        Bookings.classType,
        where: Bookings.DONE.eq(false));
  }
}
