import 'dart:typed_data';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/views/main_app_views/home_page_search.dart';
import 'package:commerce/views/main_controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../splashscreen.dart';

class DashboardView extends ConsumerWidget {
  DashboardView({Key? key}) : super(key: key);
  DashBoardController controller = Get.put(DashBoardController());
  RxString selectedItem = ''.obs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return test();
    return ref.watch(imagesProvider).when(
        data: (data) => displaydata(data, context),
        error: error,
        loading: loading);
  }

  Scaffold test() {
    return Scaffold(
        body: Center(
            child: ListView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
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
                    ...[
                      Categories(category: 'Hair', imageLinks: ['']),
                      Categories(category: 'Barbing Salon', imageLinks: ['']),
                      Categories(category: 'Driving School', imageLinks: ['']),
                      Categories(category: 'Nail salon', imageLinks: ['']),
                    ].map((category) => Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            color: const Color.fromARGB(255, 63, 63, 63),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                              height: 325,
                              child: Stack(
                                children: [
                                  const SizedBox(
                                      // child: Positioned(
                                      //     top: 0,
                                      //     left: 0,
                                      //     right: 0,
                                      child: FlutterLogo(size: 200)
                                      // )
                                      ),
                                  const Positioned(
                                      bottom: 80,
                                      left: 0,
                                      right: 0,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 90.0,
                                                right: 25.0,
                                                top: 25.0,
                                                bottom: 25.0),
                                            child: FaIcon(
                                                FontAwesomeIcons.userDoctor,
                                                color: Colors.black),
                                          ))),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Center(
                                          child: Text(category.category,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }

  Widget loading() => const Scaffold(
        body: SplashScreen(),
      );

  Widget error(Object error, StackTrace? stackTrace) =>
      const Scaffold(body: Center(child: Text("Unknown Error")));

  Widget displaydata(List<Categories> data, BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: PopupMenuButton(
              onSelected: (String selected) async =>
                  carryOutMenuAction(selected),
              icon: const Icon(Icons.menu),
              itemBuilder: (BuildContext context) {
                return ['Log out']
                    .map((item) => PopupMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList();
              },
            ),
            title: Image.asset(
              'assets/images/logo.jpeg',
              width: 70,
              height: 50,
            ),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.inbox)),
          ),
          _header(data, context)
        ],
      ),
    );
  }

  carryOutMenuAction(String selected) {
    switch (selected) {
      case 'Log out':
        logOut();
        break;
    }
  }

  logOut() async {
    await Amplify.Auth.signOut();
  }

  switchTheme() {
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
  }

  Widget _header(List<Categories> data, BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 50, right: 8.0, top: 8, bottom: 8),
                          child: Text("Find",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 50, right: 8.0, top: 8, bottom: 8),
                          child: Text("Places Around",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.7),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 50, right: 8.0, top: 8, bottom: 8),
                          child: Text("Find new places below:",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.white)),
                        )
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Card(
                              color: Colors.red[900],
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () async {
                                    await controller.search();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchDashboard()));
                                  },
                                ),
                              )),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          ListTile(
              onTap: () async {
                //
              },
              title: Padding(
                padding: const EdgeInsets.only(left: 20, right: 8.0),
                child: Row(
                  children: [
                    const Text("Get Inspired",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Row(children: const [
                      Text("See all Offers",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300)),
                      Icon(Icons.chevron_right_outlined)
                    ]),
                  ],
                ),
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...carousalItem(data, context),
                ]),
              )),
        ],
      ),
    );
  }

  List<Widget> carousalItem(List<Categories> data, BuildContext context) {
    return data.isNotEmpty
        ? data.map((category) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 325,
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
                      const Positioned(
                          bottom: 80,
                          left: 0,
                          right: 0,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 65.0,
                                    right: 25.0,
                                    top: 25.0,
                                    bottom: 25.0),
                                child: FaIcon(FontAwesomeIcons.userDoctor),
                              ))),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Center(
                              child: Text(category.category,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()
        : [const Center(child: Text("No new businesses"))];
  }

  Widget collage(Categories category, BuildContext context) {
    return category.imageLinks.length > 2
        ? Row(
            children: [
              // Image 1,
              Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .27,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      category.imageLinks[0]!,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  // image 2 and 3
                  ...category.imageLinks.sublist(1, 3).map((e) => Container(
                        height: MediaQuery.of(context).size.height * .15,
                        width: MediaQuery.of(context).size.width * .18,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              e!,
                            ),
                          ),
                        ),
                      ))
                ],
              )
            ],
          )
        : category.imageLinks.length == 2
            ? _twoImages(category.imageLinks, context)
            : category.imageLinks.length == 1
                ? Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: FittedBox(
                        child: Image.network(category.imageLinks[0]!,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.fill)),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("no businesss yet in this category"),
                    )),
                  );
  }

  Widget _twoImages(List<String?> imagesURL, BuildContext context) {
    return Column(children: [
      ...imagesURL
          .map((src) => Container(
                height: MediaQuery.of(context).size.height * .225,
                width: MediaQuery.of(context).size.width * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(src!),
                  ),
                ),
              ))
          .toList()
    ]);
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
