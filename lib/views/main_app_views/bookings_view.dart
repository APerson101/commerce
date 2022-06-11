import 'package:commerce/controllers/main_controller.dart';
import 'package:commerce/views/main_controllers/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class BookingsView extends ConsumerWidget {
  BookingsView({Key? key}) : super(key: key);

  // final MainController _controller = Get.find();
  final BookingsController controller = Get.put(BookingsController());
  bool isBusiness = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userbookingsProvider('4421')).when(
        data: (data) => showBookings(data, context),
        error: error,
        loading: loading);
  }

  Widget showBookings(List<BookingMade> allbookings, BuildContext context) {
    //
    if (isBusiness) {
      //
      return allbookings.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                  children: allbookings
                      .map(
                        (booking) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                title: Text(booking.booking.reservation!),
                                subtitle: booking.booking.done!
                                    ? Container()
                                    : ButtonBar(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('cancel')),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('approve'))
                                        ],
                                      )),
                          ),
                        ),
                      )
                      .toList()),
            )
          : const Center(child: Text("No new Bookings"));
    } else {
      // user is not a business
      return allbookings.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                  children: allbookings
                      .map(
                        (booking) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(booking.booking.reservation!),
                                  subtitle: booking.booking.done!
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await Get.defaultDialog(
                                                title: 'review',
                                                onCancel: () => Get.back(),
                                                onConfirm: () async {
                                                  await controller.saveReview(
                                                      'userId',
                                                      booking.booking.business);
                                                  Get.back();
                                                },
                                                content: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.7,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Obx(() => DropdownButton<
                                                                int>(
                                                            value: controller
                                                                .starsRating
                                                                .value,
                                                            items: [
                                                              1,
                                                              2,
                                                              3,
                                                              4,
                                                              5
                                                            ]
                                                                .map((e) =>
                                                                    DropdownMenuItem<
                                                                        int>(
                                                                      child: Text(
                                                                          e.toString()),
                                                                      value: e,
                                                                    ))
                                                                .toList(),
                                                            onChanged: (newRating) =>
                                                                controller
                                                                        .starsRating
                                                                        .value =
                                                                    newRating!)),
                                                        TextField(
                                                          onChanged: (newreview) =>
                                                              controller
                                                                      .reviewText
                                                                      .value =
                                                                  newreview,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                          child: const Text('Review'))
                                      : ElevatedButton(
                                          onPressed: () {
                                            controller.cancelBooking(
                                                booking.booking.id);
                                          },
                                          child: const Text('cancel booking')),
                                ))),
                      )
                      .toList()),
            )
          : const Center(child: Text("No new Bookings"));
    }
  }

  Widget error(dynamic Object, dynamic StackTrace) {
    return const Center(
      child: Text("Unknown Error"),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
