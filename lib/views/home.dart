import 'package:badges/badges.dart';
import 'package:commerce/controllers/home_controller.dart';
import 'package:commerce/views/main_app_views/bookings_view.dart';
import 'package:commerce/views/main_app_views/dashboard_view.dart';
import 'package:commerce/views/main_app_views/profile_view.dart';
import 'package:commerce/views/main_app_views/search_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum views { dashboard, bookings, profile, search }

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: Obx(() {
        switch (controller.currentView.value) {
          case views.bookings:
            return BookingsView();
          case views.dashboard:
            return DashboardView();
          case views.profile:
            return ProfileView();
          case views.search:
            return SearchView();
          default:
            return const Center(child: Text("Sorry cant find page"));
        }
      }),
    );
  }

  Widget _bottomNavBar() {
    return Obx(() {
      int currentIndx = views.values.indexOf(controller.currentView.value);
      return BottomNavigationBar(
          selectedItemColor: Colors.teal,
          onTap: (tappedIndex) => controller.currentView.value =
              views.values.elementAt(tappedIndex),
          currentIndex: currentIndx,
          items: views.values.map((page) {
            Widget icon;
            String label;
            switch (page) {
              case views.bookings:
                icon = Badge(
                  badgeContent: Obx(() =>
                      Text(controller.unfulfilledBookings.length.toString())),
                  child: const Icon(Icons.calendar_view_month),
                );
                label = describeEnum(page);
                break;
              case views.dashboard:
                icon = const Icon(Icons.dashboard);
                label = describeEnum(page);
                break;
              case views.search:
                icon = const Icon(Icons.search);
                label = describeEnum(page);
                break;
              case views.profile:
                icon = const Icon(Icons.person);
                label = describeEnum(page);
                break;
              default:
                icon = const Icon(Icons.cancel);
                label = "nill";
            }
            return BottomNavigationBarItem(
              icon: icon,
              label: label,
            );
          }).toList(growable: false));
    });
  }
}
