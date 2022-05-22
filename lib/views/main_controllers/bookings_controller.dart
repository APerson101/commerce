import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:commerce/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
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
      tiles.add(ListTile(
        leading: const Icon(Icons.person),
        title: Text(names[i]),
        subtitle: Text(times[i]),
      ));
    }
    return tiles;
  }

  Future<List<String>> _getNames(List<Bookings> all) async {
    List<String> names = [];
    all.forEach((booking) async {
      var list = await getUserNameFromID(booking.user!);
      var name = list[0];
      names.add(name.name!);
    });
    return names;
  }

  Future<List<ListTile>> getAllUserBookings(String userId) async {
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
      ));
    }
    return tiles;
  }
}
/*
final item = Reviews(
		userID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		businessID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		comment: "Lorem ipsum dolor sit amet",
		stars: 1020);
await Amplify.DataStore.save(item);

final updatedItem = item.copyWith(
		userID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		businessID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		comment: "Lorem ipsum dolor sit amet",
		stars: 1020);
await Amplify.DataStore.save(updatedItem);


await Amplify.DataStore.delete(toDeleteItem);

try {
  List<Reviews> Reviewss = await Amplify.DataStore.query(Reviews.classType);
} catch (e) {
  print("Could not query DataStore: " + e);
}*/

/*
final item = Bookings(
		user: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		business: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		dateTime: TemporalDateTime.fromString("1970-01-01T12:30:23.999Z"));
await Amplify.DataStore.save(item);

final updatedItem = item.copyWith(
		user: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		business: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d",
		dateTime: TemporalDateTime.fromString("1970-01-01T12:30:23.999Z"));
await Amplify.DataStore.save(updatedItem);
await Amplify.DataStore.delete(toDeleteItem);
try {
  List<Bookings> Bookingss = await Amplify.DataStore.query(Bookings.classType);
} catch (e) {
  print("Could not query DataStore: " + e);
}
*/

/**
 * final updatedItem = item.copyWith(
		type: "Lorem ipsum dolor sit amet",
		location: "Lorem ipsum dolor sit amet",
		about: "Lorem ipsum dolor sit amet",
		cac: "Lorem ipsum dolor sit amet");
await Amplify.DataStore.save(updatedItem);

final item = Businesse(
		type: "Lorem ipsum dolor sit amet",
		location: "Lorem ipsum dolor sit amet",
		about: "Lorem ipsum dolor sit amet",
		cac: "Lorem ipsum dolor sit amet");
await Amplify.DataStore.save(item);

await Amplify.DataStore.delete(toDeleteItem);

try {
  List<Businesse> Businesses = await Amplify.DataStore.query(Businesse.classType);
} catch (e) {
  print("Could not query DataStore: " + e);
}
 */

/**
 * final item = Users(
		name: "Lorem ipsum dolor sit amet",
		phone: "Lorem ipsum dolor sit amet",
		bank: "Lorem ipsum dolor sit amet",
		isBusiness: true);
await Amplify.DataStore.save(item);

final updatedItem = item.copyWith(
		name: "Lorem ipsum dolor sit amet",
		phone: "Lorem ipsum dolor sit amet",
		bank: "Lorem ipsum dolor sit amet",
		isBusiness: true);
await Amplify.DataStore.save(updatedItem);

await Amplify.DataStore.delete(toDeleteItem);

try {
  List<Users> Userss = await Amplify.DataStore.query(Users.classType);
} catch (e) {
  print("Could not query DataStore: " + e);
}
 */