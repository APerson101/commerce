import 'package:commerce/models/ModelProvider.dart';
import 'package:commerce/views/main_controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../splashscreen.dart';
import '../business_details/business_details.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(children: [
        header(context),
        ObxValue((Rx<CurrentSearchState> state) {
          switch (state.value) {
            case CurrentSearchState.searching:
              return const SplashScreen();
            case CurrentSearchState.done:
              var values = controller.searchResult.value;
              if (values.businesses.isNotEmpty) {
                return searchResults(context);
              } else {
                return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [Text("No search Result")]));
              }
            case CurrentSearchState.idle:
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Text("Search for Anything")],
                ),
              );

            default:
              return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [Text("Unknown Error")]));
          }
        }, controller.currentState)
      ]),
    ));
  }

  Widget header(BuildContext context) {
    List<int> times = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
    ];

    List<DropdownMenuItem<int>> menuitmes = [];
    menuitmes.add(
      const DropdownMenuItem(
        child: Text('Enter Time'),
        value: 300,
      ),
    );
    menuitmes.addAll(times
        .map((number) =>
            DropdownMenuItem<int>(value: number, child: Text('$number : 00')))
        .toList());

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              onChanged: (search) => controller.searchPhrase.value = search,
              decoration: InputDecoration(
                hintText: "What are you looking for?",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await controller.search();
                  },
                ),
              ),
            ),
          ),
          subtitle: ListTile(
            title: Row(children: [
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (location) =>
                          controller.locationToBeSearched.value = location,
                      decoration: InputDecoration(
                        hintText: "Location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      int? vl = controller.searchperiod.value;
                      return DropdownButton<int>(
                          hint: const Text("Enter time"),
                          value: vl,
                          items: menuitmes,
                          onChanged: (selectednumber) =>
                              controller.searchperiod.value = selectednumber!);
                    }),
                  ),
                  flex: 1)
            ]),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.all;
                        },
                        child: Text('All')),
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.barber;
                        },
                        child: Text('Barbershop')),
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.hairsalon;
                        },
                        child: Text('Hair salon')),
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.nailsalon;
                        },
                        child: Text('Nail Salon')),
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.driving;
                        },
                        child: const Text('driving school')),
                    OutlinedButton(
                        onPressed: () {
                          controller.filter.value = Searchfilters.cooking;
                        },
                        child: const Text('cooking school')),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget searchResults(BuildContext context) {
    return ObxValue((Rx<CurrentSearchState> state) {
      switch (state.value) {
        case CurrentSearchState.searching:
          return const SplashScreen();
        case CurrentSearchState.none:
          return const Center(child: Text("No Such result"));
        case CurrentSearchState.error:
          return const Center(child: Text("Unknown Error"));
        case CurrentSearchState.done:
          return displaySearchResults(context);
        default:
          return Container();
      }
    }, controller.currentState);
  }

  Widget displaySearchResults(context) {
    SearchResult businesses = controller.searchResult.value;
    return SingleChildScrollView(
      child: getChild(businesses.businesses, businesses.searchResult, context),
    );
  }

  getChild(
      List<Businesses> businesses, List<Users> users, BuildContext context) {
    return Obx(() {
      List<Card> children = [];
      switch (controller.filter.value) {
        case Searchfilters.all:
          children = filteredResult(businesses, users, context);
          break;
        case Searchfilters.barber:
          var tempBus = businesses.where((element) => element.type == 'barber');
          List<Users> tempUsers = [];
          users.forEach((element) {
            for (var temp in tempBus) {
              if (temp.id == element.id) {
                tempUsers.add(element);
                break;
              }
            }
          });
          children = filteredResult(tempBus.toList(), tempUsers, context);
          break;
        case Searchfilters.hairsalon:
          var tempBus =
              businesses.where((element) => element.type == 'Hair Salon');
          List<Users> tempUsers = [];
          users.forEach((element) {
            for (var temp in tempBus) {
              if (temp.id == element.id) {
                tempUsers.add(element);
                break;
              }
            }
          });
          children = filteredResult(tempBus.toList(), tempUsers, context);
          break;
        case Searchfilters.nailsalon:
          var tempBus =
              businesses.where((element) => element.type == 'Nail Salon');
          List<Users> tempUsers = [];
          users.forEach((element) {
            for (var temp in tempBus) {
              if (temp.id == element.id) {
                tempUsers.add(element);
                break;
              }
            }
          });
          children = filteredResult(tempBus.toList(), tempUsers, context);
          break;
        case Searchfilters.driving:
          var tempBus =
              businesses.where((element) => element.type == 'driving');
          List<Users> tempUsers = [];
          users.forEach((element) {
            for (var temp in tempBus) {
              if (temp.id == element.id) {
                tempUsers.add(element);
                break;
              }
            }
          });
          children = filteredResult(tempBus.toList(), tempUsers, context);
          break;
        case Searchfilters.cooking:
          var tempBus =
              businesses.where((element) => element.type == 'cooking');
          List<Users> tempUsers = [];
          users.forEach((element) {
            for (var temp in tempBus) {
              if (temp.id == element.id) {
                tempUsers.add(element);
                break;
              }
            }
          });
          children = filteredResult(tempBus.toList(), tempUsers, context);
          break;
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    });
  }

  List<Card> filteredResult(
      List<Businesses> businesses, List<Users> users, BuildContext context) {
    return businesses.map((business) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => BusinessDetailsView(
                    selectedBusiness: GetDetails(
                        business: business,
                        current: users[businesses.indexOf(business)])))));
          },
          child: ListTile(
            title: Text(business.location!),
            subtitle: Text(business.about!),
            leading: Text(users[businesses.indexOf(business)].name!),
          ),
        ),
      );
    }).toList();
  }
}
