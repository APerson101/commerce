import 'package:commerce/controllers/main_controller.dart';
import 'package:commerce/views/main_controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());
  MainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _contentDecider(context),
      ),
    );
  }

  List<Widget> _contentDecider(BuildContext context) {
    List<Widget> allWidgets = [];
    allWidgets.add(
      Stack(
        children: [
          FlutterLogo(
            size: 100,
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: TextButton(onPressed: () {}, child: Text("change")))
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
            onPressed: () {}, child: const Text("save changes"));
      }
      return Container();
    }));
    allWidgets.addAll(editOptions.values.map((option) {
      switch (option) {
        case editOptions.bank:
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
                  title: Text(controller.bank),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingbank.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingbank);
        case editOptions.name:
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
                  title: Text(controller.name),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingName.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingName);
        case editOptions.email:
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
                  title: Text(controller.email),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingEmail.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingEmail);
        case editOptions.number:
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
                  title: Text(controller.number),
                  trailing: TextButton(
                      onPressed: () => controller.isEditingNumber.value = true,
                      child: Text('edit')));
            }
          }, controller.isEditingNumber);
        default:
          return const Text("UNkOWN ERROR");
      }
    }).toList());

    if (_mainController.isUserBusiness) {
    } else {
      allWidgets.addAll(businessEditOptions.values.map((option) {
        switch (option) {
          case businessEditOptions.about:
            return ObxValue((RxBool value) {
              if (value.value) {
                return TextField(
                  onChanged: (newAbout) => controller.newAbout.value = newAbout,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          onPressed: () {
                            controller.isEditingbank.value = false;
                          },
                          icon: const Icon(Icons.cancel)),
                      hintText: "Enter new About",
                      prefixIcon: const Icon(Icons.info),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                );
              } else {
                return ListTile(
                    title: Text(controller.about),
                    trailing: TextButton(
                        onPressed: () => controller.isEditingAbout.value = true,
                        child: Text('edit')));
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
                    title: Text(controller.location),
                    trailing: TextButton(
                        onPressed: () =>
                            controller.isEditingLocation.value = true,
                        child: const Text('edit')));
              }
            }, controller.isEditingLocation);

          default:
            return const Text("UNkOWN ERROR");
        }
      }));
    }
    return allWidgets;
  }
}
