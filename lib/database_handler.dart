import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class StorageHandler {
  // Pick multiple images
  Future uploadImages(String businessID) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    UploadTask task;
    List<File> allFiles = [];
    images?.forEach((image) async {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('/Businesses/$businessID/${image.name}');
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': image.path},
      );
      task = ref.putFile(File(image.path), metadata);
    });
  }

// Download Image
  Future<void> downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);
  }
}
