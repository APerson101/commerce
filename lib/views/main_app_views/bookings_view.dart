import 'package:commerce/controllers/main_controller.dart';
import 'package:commerce/views/main_controllers/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsView extends StatelessWidget {
  BookingsView({Key? key}) : super(key: key);

  final MainController _controller = Get.find();
  final BookingsController controller = Get.put(BookingsController());
  @override
  Widget build(BuildContext context) {
    if (_controller.isUserBusiness) {
      return FutureBuilder(
          future: controller.getAllCompanyBookings(_controller.user!.userId),
          builder: ((context, AsyncSnapshot<List<ListTile>> snapshot) {
            if (snapshot.hasData) {
              //
              if (snapshot.data!.isNotEmpty) {
                //
                return SingleChildScrollView(
                  child: Column(children: snapshot.data!),
                );
              } else {
                return const Center(child: Text("No new Bookings"));
              }
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Unknown Error"),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }));
    } else {
      // user is not a business
      return FutureBuilder(
          future:
              controller.getAllUserBookings(_controller.user!.userId, context),
          builder: ((context, AsyncSnapshot<List<ListTile>> snapshot) {
            if (snapshot.hasData) {
              //
              if (snapshot.data!.isNotEmpty) {
                //
                return SingleChildScrollView(
                  child: Column(children: snapshot.data!),
                );
              } else {
                return const Center(child: Text("No new Bookings"));
              }
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Unknown Error"),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }));
    }
  }
}
