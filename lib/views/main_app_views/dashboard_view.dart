import 'dart:typed_data';

import 'package:commerce/views/main_controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);
  DashBoardController controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: const FlutterLogo(size: 36),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.inbox)),
        ),
        _header(context)
      ],
    );
  }

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
                      // width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for places...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
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
                  carousalItem(),
                  carousalItem(),
                  carousalItem()
                ]),
              )),
          ListTile(
            title: const Text("Special Offers"),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    specialOffers(),
                    specialOffers(),
                    specialOffers(),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget carousalItem() {
    return FutureBuilder(
        future: controller.loadAllImages(),
        builder: (context, AsyncSnapshot<List<List<Uint8List?>>> snapshot) {
          //
          if (snapshot.hasData) {
            var categories = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: categories.map((category) {
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
                              child: Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: collage(category))),
                          SizedBox(
                            child: Positioned(
                                bottom: 0,
                                top: 75,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.circle)),
                                )),
                          ),
                          const SizedBox(
                            child: Positioned(
                                left: 0,
                                right: 0,
                                bottom: 25,
                                child: SizedBox(
                                  child: Center(
                                    child: Text("Hair"),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
            );
          } else {
            return const Text("HELLO");
          }
        });
  }

  Widget collage(List<Uint8List?> images) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Image 1,
        Image.memory(images[0]!),
        Column(
          children: [
            // image 2 and 3
            Image.memory(images[1]!), Image.memory(images[2]!)
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
