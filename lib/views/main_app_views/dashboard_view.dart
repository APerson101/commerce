import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/views/main_app_views/home_page_search.dart';
import 'package:commerce/views/main_controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);
  DashBoardController controller = Get.put(DashBoardController());
  RxString selectedItem = ''.obs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: PopupMenuButton(
            onSelected: (String selected) async => carryOutMenuAction(selected),
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext context) {
              return ['Log out', 'Switch theme']
                  .map((item) => PopupMenuItem(
                        child: Text(item),
                        value: item,
                      ))
                  .toList();
            },
          ),
          title: const FlutterLogo(size: 36),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.inbox)),
        ),
        _header(context)
      ],
    );
  }

  carryOutMenuAction(String selected) {
    switch (selected) {
      case 'Log out':
        logOut();
        break;
      case 'Switch theme':
        switchTheme();
        break;
      default:
    }
  }

  logOut() async {
    await Amplify.Auth.signOut();
  }

  switchTheme() {}

  Widget _header(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: 150,
                    color: Colors.red[900],
                    child: Column(
                      children: const [
                        Text("Find"),
                        Text("Places Around"),
                        Divider(),
                        Text("Find new places below:")
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 10,
                    right: 10,
                    child: SizedBox(
                      child: TextField(
                        onChanged: (searchText) =>
                            controller.searchText.value = searchText,
                        decoration: InputDecoration(
                          hintText: "Search for places...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              await controller.search();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchDashboard()));
                            },
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          ListTile(
              title: Row(
                children: const [
                  Text("Get Inspired"),
                  Spacer(),
                  Text("See all Offers")
                ],
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  carousalItem(),
                ]),
              )),
          // ListTile(
          //   title: const Text("Special Offers"),
          //   subtitle: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           specialOffers(),
          //           specialOffers(),
          //           specialOffers(),
          //         ],
          //       )),
          // ),
        ],
      ),
    );
  }

  Widget carousalItem() {
    return FutureBuilder(
        future: controller.loadAllImages(),
        builder: (context, AsyncSnapshot<List<List<String?>>> snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data!;
            return Obx(() {
              return controller.allItems.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: controller.allItems.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                              height: 225,
                              child: Stack(
                                children: [
                                  SizedBox(
                                      // child: Positioned(
                                      //     top: 0,
                                      //     left: 0,
                                      //     right: 0,
                                      child: collage(category, context)
                                      // )
                                      ),
                                  SizedBox(
                                    // child: Positioned(
                                    //     bottom: 0,
                                    //     top: 75,
                                    //     left: 0,
                                    //     right: 0,
                                    child: SizedBox(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.circle)),
                                      // )
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   child: Positioned(
                                  //       left: 0,
                                  //       right: 0,
                                  //       bottom: 25,
                                  //       child: SizedBox(
                                  //         child: Center(
                                  //           child: Text("Hair"),
                                  //         ),
                                  //       )),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                    )
                  : const Center(child: Text("No new businesses"));
            });
          } else {
            return const Text("HELLO");
          }
        });
  }

  Widget collage(List<String?> images, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Image 1,
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.network(images[0]!)),
        Column(
          children: [
            // image 2 and 3
            ...images.sublist(1).map((e) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.network(e!)))
          ],
        )
      ],
    );
  }

  Widget specialOffers() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: const [
              Positioned(
                  child: SizedBox(
                child: FlutterLogo(size: 250),
              )),
              Positioned(
                  top: 0,
                  bottom: 50,
                  child: SizedBox(child: Text("Owner Shop")))
            ],
          ),
        ));
  }
}
