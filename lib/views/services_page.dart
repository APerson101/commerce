import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/controllers/main_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/ModelProvider.dart';
import 'business_details/business_details_controller.dart';

class ServicesPaegBusiness extends ConsumerWidget {
  ServicesPaegBusiness({Key? key, required this.business}) : super(key: key);
  final BusinessDetailsModel business;
  final ServiesController controller = Get.put(ServiesController());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onTap: () => controller.isSearching.value = true,
              onChanged: (text) => controller.serachText.value = text,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () async {
                        controller.search();
                      },
                      icon: const Icon(Icons.search)),
                  hintText: 'Search for services',
                  suffixIcon: Obx(() => controller.isSearching.value
                      ? IconButton(
                          onPressed: () {
                            controller.isSearching.value = false;
                          },
                          icon: const Icon(Icons.cancel))
                      : Container())),
            ),
          ),
          Text(
            business.business.type!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ElevatedButton(
              onPressed: () async {
                Get.defaultDialog(
                    title: 'booking',
                    onCancel: () => Get.back(),
                    onConfirm: () => Get.defaultDialog(
                        content: const Text('Confirm Boooking?'),
                        onCancel: () => Get.back(),
                        onConfirm: () async {
                          Get.back();
                          await controller.makeBooking(business);
                        }),
                    content: DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2023),
                      dateLabelText: 'Date Time',
                      dateMask: 'd MMMM, yyyy - hh:mm a',
                      onChanged: (newselection) {
                        controller.dateSelected.value = newselection;
                      },
                    ));
              },
              child: const Text("Book"))
        ],
      ),
    );
  }
}

class ServiesController extends GetxController {
  RxBool isSearching = false.obs;
  RxString serachText = ''.obs;
  RxString dateSelected = ''.obs;
  Rx<bookingsStatuses> bookingStatus = bookingsStatuses.idle.obs;
  search() {}
  makeBooking(BusinessDetailsModel business) async {
    MainController _ctrl = Get.find();
    try {
      bookingStatus.value = bookingsStatuses.loading;
      await Amplify.DataStore.save<Bookings>(Bookings(
          id: const Uuid().v4(),
          user: _ctrl.user.userId,
          reservation: dateSelected.value,
          business: business.business.id,
          dateTime: TemporalDateTime.now(),
          done: false));
      bookingStatus.value = bookingsStatuses.done;
    } catch (e) {
      bookingStatus.value = bookingsStatuses.error;
    }

    if (bookingStatus.value == bookingsStatuses.done) {
      Get.snackbar('booking', "New Booking awaiting approval");
    }

    if (bookingStatus.value == bookingsStatuses.error) {
      Get.snackbar('booking', "Unable to create new booking");
    }
  }
}
