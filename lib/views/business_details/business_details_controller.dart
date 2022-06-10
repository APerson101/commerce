import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:commerce/models/ModelProvider.dart';
import 'package:uuid/uuid.dart';

import '../main_controllers/search_controller.dart';

final getFakedetailsProvider =
    FutureProvider.family<BusinessDetailsModel, GetDetails>(
        (ref, searchresult) async {
  List<Reviews> allReviews = [];
  allReviews.addAll({
    Reviews(
        id: 'fdgdfsf',
        userID: '673456',
        businessID: '453453',
        comment: 'This product sucks, dont ever user anything from them',
        stars: 3),
    Reviews(
        id: 'fdgdfsf',
        userID: '673456',
        businessID: '453453',
        comment: 'This product sucks, dont ever user anything from them',
        stars: 3),
    Reviews(
        id: 'fdgdfsf',
        userID: '673456',
        businessID: '453453',
        comment: 'This product sucks, dont ever user anything from them',
        stars: 3),
    Reviews(
        id: 'fdgdfsf',
        userID: '673456',
        businessID: '453453',
        comment: 'This product sucks, dont ever user anything from them',
        stars: 3),
    Reviews(
        id: 'fdgdfsf',
        userID: '673456',
        businessID: '453453',
        comment: 'This product sucks, dont ever user anything from them',
        stars: 3),
  });
  return BusinessDetailsModel(
    name: searchresult.current.name!,
    business: searchresult.business,
    user: searchresult.current,
    allReviews: allReviews,
    images: const [
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://media.istockphoto.com/vectors/vector-illustration-of-red-house-icon-vector-id155666671?k=20&m=155666671&s=612x612&w=0&h=sL5gRpVmrGcZBVu5jEjF5Ne7A4ZrBCuh5d6DpRv3mps=',
      'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/08/download-23.jpg'
    ],
  );
});

final getDetailsProvider = FutureProvider.family<BusinessDetailsModel, String>(
    (ref, businessID) async {
  var results = await Amplify.DataStore.query(Users.classType,
      where: Users.ID.eq(businessID),
      pagination: const QueryPagination.firstPage());
  String username = results[0].name!;

  var businessResult = await Amplify.DataStore.query(Businesses.classType,
      where: Businesses.ID.eq(businessID),
      pagination: const QueryPagination.firstPage());
  var businessModel = businessResult[0];

  var reviewResults = await Amplify.DataStore.query(
    Reviews.classType,
    where: Reviews.BUSINESSID.eq(businessID),
  );

  List<String> imagerefs = results[0].pics;
  List<String> downloadsURLS = [];
  imagerefs.forEach((element) async {
    downloadsURLS
        .add(await FirebaseStorage.instance.ref(element).getDownloadURL());
  });
  BusinessDetailsModel dets = BusinessDetailsModel(
      name: username,
      business: businessModel,
      allReviews: reviewResults,
      user: results[0],
      images: downloadsURLS);
  return dets;
});

class BusinessDetailsController extends GetxController {
  Rx<bookingsStatuses> bookingStatus = bookingsStatuses.idle.obs;

  confirmBooking(
    String reservation,
    BusinessDetailsModel details,
  ) async {
    try {
      bookingStatus.value = bookingsStatuses.loading;
      AuthUser currentUser = await Amplify.Auth.getCurrentUser();
      await Amplify.DataStore.save<Bookings>(Bookings(
          id: const Uuid().v4(),
          user: currentUser.userId,
          reservation: reservation,
          business: details.business.id,
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

enum bookingsStatuses { loading, done, idle, error }

class BusinessDetailsModel {
  String name;
  Businesses business;
  List<String> images;
  Users user;
  List<Reviews> allReviews;
  BusinessDetailsModel({
    required this.name,
    required this.business,
    required this.images,
    required this.user,
    required this.allReviews,
  });
}
