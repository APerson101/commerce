import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:commerce/models/ModelProvider.dart';
import 'package:riverpod/riverpod.dart';

final imagesProvider = FutureProvider((ref) async {
  return await Future.delayed(Duration(seconds: 1), () {
    List<Categories> allCategories = [];
    List<String> cats = <String>[];
    cats.addAll(
        {"Barbing salon", "Hair Salon", "Nail Salon", "Driving School"});
    cats.forEach((category) async {
      FirebaseStorage _storage = FirebaseStorage.instance;
      var listOfResultCategories =
          await _storage.ref('Businesses/$category').listAll();
      List<Reference> allBusinesses = listOfResultCategories.items;
      List<String?> imagesData = [];

      allBusinesses.forEach((all) async {
        String? data = await all.getDownloadURL();
        var metadata = await all.getMetadata();
        imagesData.add(data);
      });
      allCategories.add(Categories(category: category, imageLinks: imagesData));
    });
    return allCategories;
  });
});

class DashBoardController extends GetxController {
  RxList<List<String?>> allItems = <List<String?>>[].obs;

  RxString searchText = ''.obs;
  RxList<Businesses> searchResultBusinesses = <Businesses>[].obs;
  RxList<Users> searchResultNames = <Users>[].obs;
  Rx<searchstatus> currentSearchStatus = searchstatus.idle.obs;

  Future<bool> search() async {
    currentSearchStatus.value = searchstatus.searching;
    var searchResultNames = await Amplify.DataStore.query(
      Users.classType,
      where: Users.NAME.eq(searchText.value).and(Users.ISBUSINESS.eq(true)),
    );
    searchResultNames.forEach((userID) async {
      var currentResult = await Amplify.DataStore.query(Businesses.classType,
          where: Businesses.ID.eq(userID.id),
          pagination: const QueryPagination.firstResult());
      searchResultBusinesses.add(currentResult[0]);
    });
    currentSearchStatus.value = searchstatus.done;
    return true;
  }
}

enum searchstatus { searching, done, error, idle }

class Categories {
  String category;
  List<String?> imageLinks;
  Categories({
    required this.category,
    required this.imageLinks,
  });
}
