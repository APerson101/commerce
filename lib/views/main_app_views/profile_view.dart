import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/controllers/main_controller.dart';
import 'package:commerce/models/Users.dart';
import 'package:commerce/views/home.dart';
import 'package:commerce/views/main_controllers/profile_controller.dart';
import 'package:commerce/views/sign_up_contd_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../controllers/home_controller.dart';
import '../../splashscreen.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  MainController _mainController = Get.find();
  bool thihngs = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProfileEditor> profile;
    // if (_mainController.isUserBusiness) {
    //   profile = ref.watch(businessInfoProvider(_mainController.user.userId));
    // } else {
    //   profile = ref.watch(profileProvider('dfd'));
    // }
    return ref.watch(getuserProvider(_mainController.user.userId)).when(
        data: (value) {
      if (value.isBusiness) {
        profile = ref.watch(businessInfoProvider(_mainController.user.userId));
      } else {
        profile = ref.watch(profileProvider(_mainController.user.userId));
      }
      return profile.when(data: (ProfileEditor data) {
        return Scaffold(
          appBar: AppBar(title: const Text("Edit Profile")),
          body: SingleChildScrollView(
            child: Column(
              children: !thihngs
                  ? _contentDecider(context, data)
                  : _busineessProfile(context, data),
            ),
          ),
        );
      }, loading: () {
        return Scaffold(
          appBar: AppBar(),
          body: SplashScreen(),
        );
      }, error: (Object error, StackTrace? stackTrace) {
        return const Scaffold(
          body: Center(child: Text("Error")),
        );
      });
    }, loading: () {
      return Scaffold(
        appBar: AppBar(),
        body: const SplashScreen(),
      );
    }, error: (Object error, StackTrace? stackTrace) {
      return const Scaffold(
        body: Center(child: Text("Error")),
      );
    });
  }

  List<Widget> _contentDecider(BuildContext context, ProfileEditor data) {
    List<Widget> allWidgets = [];
    allWidgets.add(
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Image.network(
                  data.url!,
                  // loadingBuilder: ((context, child, loadingProgress) =>
                  //     CircularProgressIndicator.adaptive()),
                )),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: TextButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      Get.defaultDialog(
                          title: 'Confirm',
                          content: const ListTile(
                            title: Text("Save new Image"),
                          ),
                          onCancel: () {
                            Get.back();
                            image = null;
                          },
                          onConfirm: () {
                            controller.newImage = image;
                          });
                    }
                  },
                  child: const Text("change")))
        ],
      ),
    );

    allWidgets.add(Obx(() {
      //
      if (controller.isEditingEmail.value ||
          controller.isEditingName.value ||
          controller.isEditingNumber.value ||
          controller.isEditingbank.value ||
          controller.isEditingAbout.value ||
          controller.isEditingLocation.value) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 60)),
            onPressed: () {},
            child: const Text("save changes"));
      }
      return Container();
    }));
    allWidgets.addAll(editOptions.values.map((option) {
      switch (option) {
        case editOptions.bank:
          return ObxValue((RxBool value) {
            if (value.value) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (newbank) => controller.newBank.value = newbank,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            controller.isEditingbank.value = false;
                          },
                          icon: const Icon(Icons.cancel)),
                      hintText: "Enter new Bank",
                      prefixIcon: const Icon(Icons.house),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                      title: Text(data.userDetails.bank!),
                      trailing: TextButton(
                          onPressed: () =>
                              controller.isEditingbank.value = true,
                          child: Text('edit'))),
                ),
              );
            }
          }, controller.isEditingbank);
        case editOptions.name:
          return ObxValue((RxBool value) {
            if (value.value) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (newName) => controller.newName.value = newName,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            controller.isEditingName.value = false;
                          },
                          icon: const Icon(Icons.cancel)),
                      hintText: "Enter new Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                      title: Text(data.userDetails.name!),
                      trailing: TextButton(
                          onPressed: () =>
                              controller.isEditingName.value = true,
                          child: Text('edit'))),
                ),
              );
            }
          }, controller.isEditingName);
        case editOptions.email:
          return ObxValue((RxBool value) {
            if (value.value) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (newEmail) => controller.newEmail.value = newEmail,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            controller.isEditingEmail.value = false;
                          },
                          icon: const Icon(Icons.cancel)),
                      hintText: "Enter new Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                      // title: Text(_mainController.user.username),
                      title: const Text('emailthings@gmail.com'),
                      trailing: TextButton(
                          onPressed: () =>
                              controller.isEditingEmail.value = true,
                          child: const Text('edit'))),
                ),
              );
            }
          }, controller.isEditingEmail);
        case editOptions.number:
          return ObxValue((RxBool value) {
            if (value.value) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (newNumber) =>
                      controller.newNumber.value = newNumber,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            controller.isEditingNumber.value = false;
                          },
                          icon: const Icon(Icons.cancel)),
                      hintText: "Enter new Number",
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                      title: Text(data.userDetails.number!),
                      trailing: TextButton(
                          onPressed: () =>
                              controller.isEditingNumber.value = true,
                          child: const Text('edit'))),
                ),
              );
            }
          }, controller.isEditingNumber);
        default:
          return const Text("UNkOWN ERROR");
      }
    }).toList());

    return allWidgets;
  }

  List<Widget> _busineessProfile(BuildContext context, ProfileEditor data) {
    List<Widget> allWidgets = [];
    // int reservations = await controller.getReservations(data.business!.id);
    int reservations = 1;
    allWidgets.add(Obx(() {
      return (controller.isbusinessEditing.value ||
              controller.isEditingName.value ||
              controller.isEditingbank.value ||
              controller.isEditingEmail.value ||
              controller.isEditingNumber.value ||
              controller.isEditingAbout.value ||
              controller.isEditingLocation.value)
          ? ElevatedButton(
              onPressed: () async {
                bool status = await controller.saveChanges(data);
                if (status) {
                  Get.snackbar('update', 'update saved successfully');
                } else {
                  Get.snackbar('update', 'failed to save update');
                }
              },
              child: const Text("Save changes"))
          : Container();
    }));
    allWidgets.add(SingleChildScrollView(
        child: Row(
          children: data.businessList!
              .map((e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.network(
                        e,
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ))
              .toList(),
        ),
        scrollDirection: Axis.horizontal));
    allWidgets.add(ElevatedButton(
        onPressed: () async {
          controller.isbusinessEditing.value = true;
          List<XFile>? newImages = await ImagePicker().pickMultiImage();
          if (newImages == null) {
            controller.isbusinessEditing.value = false;
            controller.newImages.value = [];
          } else {
            controller.newImages.value = newImages;
          }
        },
        child: const Text("Change Pics")));
    allWidgets.addAll(businessEditOptions.values.map((option) {
      switch (option) {
        case businessEditOptions.cac:
          return Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text("CAC"),
              subtitle: Text(data.business!.cac!),
            ),
          );
        case businessEditOptions.bank:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newbank) => controller.newBank.value = newbank,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingbank.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new Bank",
                    prefixIcon: const Icon(Icons.house),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(data.userDetails.bank!),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingbank.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingbank);
        case businessEditOptions.name:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newName) => controller.newName.value = newName,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingName.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(data.userDetails.name!),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingName.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingName);
        case businessEditOptions.email:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newEmail) => controller.newEmail.value = newEmail,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingEmail.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(_mainController.user.username),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingEmail.value = true,
                      child: const Text('edit')));
            }
          }, controller.isEditingEmail);
        case businessEditOptions.number:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newNumber) =>
                    controller.newNumber.value = newNumber,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingNumber.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new Number",
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(data.userDetails.number!),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingNumber.value = true,
                      child: const Text('edit')));
            }
          }, controller.isEditingNumber);
        case businessEditOptions.reservations:
          return GestureDetector(
            onTap: () {
              HomeController controler = Get.find();
              controler.currentView.value = views.bookings;
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: const Text("Upcoming Reservations"),
                  subtitle: Row(children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.green,
                    ),
                    Text('$reservations need confirmation')
                  ]),
                ),
              ),
            ),
          );
        case businessEditOptions.availability:
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListTile(
                      title: const Text("Edit Business Hours"),
                      subtitle: Column(
                        children: DaysWeek.values
                            .map((e) => Row(
                                  children: [
                                    Text(describeEnum(e)),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () async {
                                          TimeRange result =
                                              await showTimeRangePicker(
                                            context: context,
                                            interval:
                                                const Duration(minutes: 30),
                                          );
                                          controller.isbusinessEditing.value =
                                              true;
                                        },
                                        child: Text(
                                            data.availability?[e] ?? "Closed"))
                                  ],
                                ))
                            .toList(),
                      ))));
        case businessEditOptions.about:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newAbout) => controller.newAbout.value = newAbout,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingAbout.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new About",
                    prefixIcon: const Icon(Icons.info),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(data.business!.about!),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingAbout.value = true,
                      child: const Text('edit')));
            }
          }, controller.isEditingAbout);

        case businessEditOptions.location:
          return ObxValue((RxBool value) {
            if (value.value) {
              return TextField(
                onChanged: (newLocation) =>
                    controller.newLocation.value = newLocation,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          controller.isEditingLocation.value = false;
                        },
                        icon: const Icon(Icons.cancel)),
                    hintText: "Enter new Location",
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              );
            } else {
              return ListTile(
                  title: Text(data.business!.location!),
                  trailing: TextButton(
                      onPressed: () =>
                          controller.isEditingLocation.value = true,
                      child: const Text('edit')));
            }
          }, controller.isEditingLocation);

        default:
          return const Text("unknown");
      }
    }));

    return allWidgets;
  }
}
