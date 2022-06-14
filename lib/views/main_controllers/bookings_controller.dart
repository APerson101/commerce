import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:commerce/views/business_details/business_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

final userbookingsProvider =
    FutureProvider.family<List<BookingMade>, String>((ref, userID) async {
  return Future.delayed(const Duration(seconds: 1), () {
    return [
      BookingMade(
          booking: Bookings(
            id: '8867',
            user: 'user',
            business: '54321',
            dateTime: TemporalDateTime.now(),
            done: true,
            reservation: '26-09-2022, 09:00AM - 10:00AM',
          ),
          businessName: 'Fads Spoon'),
      BookingMade(
          booking: Bookings(
            id: '8867',
            user: 'user',
            business: '54321',
            dateTime: TemporalDateTime.now(),
            done: false,
            reservation: '26-09-2022, 09:00AM - 10:00AM',
          ),
          businessName: 'Fads Spoon'),
      BookingMade(
          booking: Bookings(
            id: '8867',
            user: 'user',
            business: '54321',
            dateTime: TemporalDateTime.now(),
            done: true,
            reservation: '26-09-2022, 09:00AM - 10:00AM',
          ),
          businessName: 'Fads Spoon'),
      BookingMade(
          booking: Bookings(
            id: '8867',
            user: 'user',
            business: '54321',
            dateTime: TemporalDateTime.now(),
            done: false,
            reservation: '26-09-2022, 09:00AM - 10:00AM',
          ),
          businessName: 'Fads Spoon'),
      BookingMade(
          booking: Bookings(
            id: '8867',
            user: 'user',
            business: '54321',
            dateTime: TemporalDateTime.now(),
            done: true,
            reservation: '26-09-2022, 09:00AM - 10:00AM',
          ),
          businessName: 'Fads Spoon'),
    ];
  });
});

class BookingsController extends GetxController {
  RxList<ListTile> companyBookings = <ListTile>[].obs;
  RxString reviewText = ''.obs;
  RxInt starsRating = 5.obs;
  Future<List<Users>> getUserNameFromID(String nameID) async {
    //returns the first result matching the ID
    return await Amplify.DataStore.query(Users.classType,
        where: Users.ID.eq(nameID),
        pagination: const QueryPagination.firstResult());
  }

  Future<List<ListTile>> getAllCompanyBookings(String userId) async {
    var bookings = await Amplify.DataStore.query(Bookings.classType,
        where: Bookings.BUSINESS.eq(userId));
    var names = await _getNames(bookings);
    List<String> times = [];
    bookings.forEach((booking) {
      times.add(booking.dateTime!.getDateTimeInUtc().toIso8601String());
    });
    List<ListTile> tiles = [];
    for (var i = 0; i < bookings.length; i++) {
      companyBookings.add(ListTile(
        leading: const Icon(Icons.person),
        title: Text(names[i]),
        subtitle: Text(times[i]),
        trailing: bookings[i].done!
            ? Container()
            : ButtonBar(children: [
                ElevatedButton(
                    onPressed: () async {
                      Amplify.DataStore.save(bookings[i].copyWith(done: true));
                      Get.snackbar('booking', 'booking confirmed');
                    },
                    child: const Text("confirm")),
                ElevatedButton(
                    onPressed: () async {
                      Amplify.DataStore.delete(bookings[i]);
                      companyBookings.removeAt(i);
                      Get.snackbar('booking', 'booking canceled');
                    },
                    child: const Text("Cancel")),
              ]),
      ));
    }
    return tiles;
  }

  Future<List<String>> _getNames(List<Bookings> all) async {
    List<String> names = [];
    all.forEach((booking) async {
      var list = await getUserNameFromID(booking.user);
      var name = list[0];
      names.add(name.name);
    });
    return names;
  }

  Future<List<ListTile>> getAllUserBookings(
      String userId, BuildContext context) async {
    var bookings = await Amplify.DataStore.query(Bookings.classType,
        where: Bookings.USER.eq(userId));
    var names = await _getNames(bookings);
    List<String> times = [];
    bookings.forEach((booking) {
      times.add(booking.dateTime!.getDateTimeInUtc().toIso8601String());
    });
    List<ListTile> tiles = [];
    for (var i = 0; i < bookings.length; i++) {
      tiles.add(ListTile(
        leading: const Icon(Icons.person),
        title: Text(names[i]),
        subtitle: Text(times[i]),
        trailing: bookings[i].done!
            ? ElevatedButton(
                onPressed: () async {
                  await Get.defaultDialog(
                      onCancel: () => Get.back(),
                      onConfirm: () async {
                        await saveReview(userId, bookings[i].id);
                        Get.back();
                      },
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(() => DropdownButton<int>(
                                  value: starsRating.value,
                                  items: [1, 2, 3, 4, 5]
                                      .map((e) => DropdownMenuItem<int>(
                                          child: Text(e.toString())))
                                      .toList(),
                                  onChanged: (newRating) =>
                                      starsRating.value = newRating!)),
                              TextField(
                                onChanged: (newreview) =>
                                    reviewText.value = newreview,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                child: const Text("Review"))
            : ElevatedButton(
                onPressed: () async {
                  Amplify.DataStore.delete(bookings[i]);
                  companyBookings.removeAt(i);
                  Get.snackbar('booking', 'booking canceled');
                },
                child: const Text("Cancel")),
      ));
    }
    return tiles;
  }

  saveReview(String userId, String businessID) async {
    //
    await Amplify.DataStore.save<Reviews>(Reviews(
        id: Uuid().v4(),
        comment: reviewText.value,
        userID: userId,
        businessID: businessID,
        stars: starsRating.value));
  }

  cancelBooking(String bookingID) {}
}

class BookingMade {
  Bookings booking;
  String businessName;

  BookingMade({required this.booking, required this.businessName});
}
