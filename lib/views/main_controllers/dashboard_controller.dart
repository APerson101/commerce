import 'dart:typed_data';

import 'package:commerce/database_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  StorageHandler storageHandler = StorageHandler();

  loadImages(Reference ref) async {
    storageHandler.downloadFile(ref);
  }

  Future<List<List<Uint8List?>>> loadAllImages() async {
    String barbers = 'Businesses/barber';
    String salons = 'Businesses/HairSalon';
    String nails = 'Businesses/NailSalon';
    String driving = 'Businesses/DrivingSchool';
    List<String> allReferences = [];

    List<List<Uint8List?>> allItems = [];
    allReferences.add(barbers);
    allReferences.add(salons);
    allReferences.add(nails);
    allReferences.add(driving);
    FirebaseStorage _storage = FirebaseStorage.instance;
    allReferences.forEach((eahc) async {
      var list_of_result = await _storage.ref(eahc).listAll();
      List<Reference> all = list_of_result.items;
      List<Uint8List?> imagesData = [];
      all.forEach((item) async {
        Uint8List? data = await item.getData();
        imagesData.add(data);
        allItems.add(imagesData);
      });
    });
    return allItems;
  }
}
