import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxList<List<String?>> allItems = <List<String?>>[].obs;
  RxString searchText = ''.obs;
  RxList<Businesses> searchResultBusinesses = <Businesses>[].obs;
  RxList<Users> searchResultNames = <Users>[].obs;
  Rx<searchstatus> currentSearchStatus = searchstatus.idle.obs;
  Future<List<List<String?>>> loadAllImages() async {
    String barbers = 'Businesses/Barbing salon';
    String salons = 'Businesses/Hair Salon';
    String nails = 'Businesses/Nail Salon';
    String driving = 'Businesses/Driving School';
    List<String> allReferences = [];
    List<List<String?>> allItems = [];
    allReferences.add(barbers);
    allReferences.add(salons);
    allReferences.add(nails);
    allReferences.add(driving);
    FirebaseStorage _storage = FirebaseStorage.instance;
    allReferences.forEach((eahc) async {
      var list_of_result_categories = await _storage.ref(eahc).listAll();
      List<Reference> all_businesses = list_of_result_categories.items;
      all_businesses.forEach((all) async {
        var list_of_business_images =
            await _storage.ref(all.fullPath).listAll();
        List<Reference> image_references = list_of_business_images.items;
        List<String?> imagesData = [];
        image_references.forEach((item) async {
          String? data = await item.getDownloadURL();
          imagesData.add(data);
          this.allItems.add(imagesData);
        });
      });
    });
    return allItems;
  }

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
