import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:commerce/models/ModelProvider.dart';

class BusinessDetailsController extends GetxController {
  Future<BusinessDetailsModel> getDetails(String businessID) async {
    //get name;
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

    var imagesList = await FirebaseStorage.instance
        .ref('Businesses/category/$businessID')
        .listAll();
    List<Image> allImage = [];
    imagesList.items.forEach((element) async {
      Uint8List? data = await element.getData();
      allImage.add(Image.memory(data!));
    });
    BusinessDetailsModel dets = BusinessDetailsModel(
        name: username,
        business: businessModel,
        allReviews: reviewResults,
        images: allImage);
    return dets;
  }

  confirmBooking(String value, int value2) async {}
}

class BusinessDetailsModel {
  String name;
  Businesses business;
  List<Image> images;
  List<Reviews> allReviews;
  BusinessDetailsModel({
    required this.name,
    required this.business,
    required this.images,
    required this.allReviews,
  });
}
