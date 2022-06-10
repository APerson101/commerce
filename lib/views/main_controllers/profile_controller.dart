import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:commerce/views/sign_up_contd_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

enum editOptions { name, bank, email, number }

enum businessEditOptions {
  about,
  images,
  location,
  availability,
  reservations,
  bank,
  name,
  email,
  number,
  cac
}

final profileProvider =
    FutureProvider.family<ProfileEditor, String>((ref, userId) async {
  return ProfileEditor(
      url:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      userDetails: Users(
          pics: const [
            'https://www.keepinspiring.me/wp-content/uploads/2012/10/quotes-about-sisters-feature.jpg?ezimgfmt=ng:webp/ngcb71'
          ],
          id: '4421',
          name: 'Test name',
          isBusiness: false,
          country: "Nigeria",
          bank: "GTB",
          number: '08159730537',
          cac: '4423212'));
  var userDetails = await Amplify.DataStore.query(Users.classType,
      where: Users.ID.eq(userId));
  var profilePicURL = userDetails[0].pics;

  var userImageURL =
      await FirebaseStorage.instance.ref('Users/$userId').getDownloadURL();
  return ProfileEditor(url: userImageURL, userDetails: userDetails[0]);
});

final businessInfoProvider =
    FutureProvider.family<ProfileEditor, String>((ref, userId) async {
  var userImageList_ =
      await FirebaseStorage.instance.ref('Businesses/Hair Salon').listAll();
  List<String> specified = [];
  userImageList_.items.forEach((element) async {
    var metadata = await element.getMetadata();
    var userID = metadata.customMetadata!['userID'];
    if (userID == userId) {
      specified.add(await element.getDownloadURL());
    }
  });
  Map<DaysWeek, String> availability_ = {};
  List<int> dyz = [0, 1, 2];
  List<String> tmz = [
    '08:00am - 16:00pm',
    '09:00am - 12:00 noon',
    '10:00am - 17:00pm',
  ];
  for (var i = 0; i < dyz.length; i++) {
    availability_.addAll({DaysWeek.values[dyz[i]]: tmz[i]});
  }
  return ProfileEditor(
    userDetails: Users(
      id: userId,
      name: 'Kehinde Shop',
      bank: 'Hello World',
      isBusiness: true,
      country: 'Nigeria',
      number: '081597',
      pics: const [],
    ),
    businessList: specified,
    availability: availability_,
    business: Businesses(
        id: userId,
        type: 'Hair Salon',
        location: 'Abuja',
        about: 'Omo e get as e be, but God no go shame us',
        cac: '44ffre',
        availableTimes: tmz,
        AvailableDays: dyz),
  );
  var userDetails = await Amplify.DataStore.query(Users.classType,
      where: Users.ID.eq(userId));
  var businessdetails = await Amplify.DataStore.query(Businesses.classType,
      where: Businesses.ID.eq(userId));
  String businessType = businessdetails[0].type!;
  var userImageList = await FirebaseStorage.instance
      .ref('Businesses/$businessType/$userId')
      .listAll();
  Map<String, String> availability = {};
  for (var i = 0; i < businessdetails[0].AvailableDays!.length; i++) {
    availability.addAll({
      describeEnum(DaysWeek.values[businessdetails[0].AvailableDays![i]]):
          businessdetails[0].availableTimes![i]
    });
  }
  businessdetails[0].availableTimes;
  // return ProfileEditor(
  //     // businessList: userImageList,
  //     userDetails: userDetails[0],
  //     availability: availability,
  //     business: businessdetails[0]);
});

class ProfileEditor {
  String? url;
  Users userDetails;
  List<String>? businessList;
  Businesses? business;
  Map<DaysWeek, String>? availability;
  ProfileEditor(
      {this.url,
      required this.userDetails,
      this.business,
      this.businessList,
      this.availability});
}

class ProfileController extends GetxController {
  String name = 'Test Name';
  String bank = 'Test Bank';
  String email = 'Test Email@gmail.com';
  String number = '081234567890';
  RxBool isEditingName = false.obs;
  RxBool isEditingbank = false.obs;
  RxBool isEditingEmail = false.obs;
  RxBool isEditingNumber = false.obs;
  XFile? newImage;
  RxList<XFile> newImages = <XFile>[].obs;
  RxString newName = ''.obs;
  RxString newBank = ''.obs;
  RxString newEmail = ''.obs;
  RxString newNumber = ''.obs;

// Business stuffs
  String about = 'default ABout';
  String location = 'default Location';

  RxBool isEditingAbout = false.obs;
  RxBool isEditingLocation = false.obs;

  RxString newAbout = ''.obs;
  RxString newLocation = ''.obs;
  RxBool isbusinessEditing = false.obs;
  saveChanges(ProfileEditor data) async {
    Users currentuser = data.userDetails;
    Users updated = currentuser.copyWith(
      name: isEditingName.value ? newName.value : null,
      bank: isEditingbank.value ? newBank.value : null,
      number: isEditingNumber.value ? newNumber.value : null,
    );
    if (data.userDetails.isBusiness!) {
      Businesses currentBusiness = data.business!;
      Businesses updated = currentBusiness.copyWith(
        about: isEditingAbout.value ? newAbout.value : null,
        location: isEditingLocation.value ? newLocation.value : null,

        ///days and time
      );
    }

    if (isbusinessEditing.value) {
      // save new images

      if (newImages.isNotEmpty) {
        var references = await FirebaseStorage.instance
            .ref('Businesses/${data.business!.type!}')
            .listAll();
        references.items.forEach((element) {
          element.delete();
        });

        newImages.forEach((element) async {
          await FirebaseStorage.instance
              .ref('Businesses/${data.business!.type}')
              .child('image ${newImages.indexOf(element)}.png')
              .putData(
                  await element.readAsBytes(),
                  SettableMetadata(
                      contentType: 'images/png',
                      customMetadata: {'userID': '4421'}));
        });
      }
    }

    Amplify.DataStore.save<Users>(updated,
        where: Users.ID.eq(data.userDetails.id));
  }

  Future<int> getReservations(String userId) async {
    var bookings = await Amplify.DataStore.query(Bookings.classType,
        where: Bookings.BUSINESS.eq(userId).and(Bookings.DONE.eq(false)));
    return bookings.length;
  }
}


/**
 * profile edit
 * search
 * booking
 * dashboard
 */