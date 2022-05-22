import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          title: const FlutterLogo(size: 36),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.inbox)),
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
                      children: [
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
                            icon: Icon(Icons.search),
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
                children: [
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
            title: Text("Special Offers"),
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
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 225,
          child: Stack(
            children: [
              SizedBox(
                  child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FlutterLogo(
                  size: 150,
                ),
              )),
              SizedBox(
                child: Positioned(
                    bottom: 0,
                    top: 75,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.circle)),
                    )),
              ),
              SizedBox(
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
  }

  Widget specialOffers() {
    return Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
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
