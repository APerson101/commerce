import 'dart:html';

import 'package:commerce/models/ModelProvider.dart';
import 'package:commerce/views/main_controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../business_details/business_details.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return ListView(children: [header(context), searchResults(context)]);
  }

  Widget header(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextField(
              decoration: InputDecoration(
                hintText: "What are you looking for",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          subtitle: ListTile(
            title: Row(children: [
              Expanded(
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
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
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "When?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  flex: 1)
            ]),
            subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(onPressed: () {}, child: Text('All')),
                    OutlinedButton(onPressed: () {}, child: Text('Barbershop')),
                    OutlinedButton(onPressed: () {}, child: Text('Hair salon')),
                    OutlinedButton(onPressed: () {}, child: Text('Nail Salon')),
                    OutlinedButton(
                        onPressed: () {}, child: Text('driving school')),
                    OutlinedButton(
                        onPressed: () {}, child: Text('cooking school')),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget searchResults(BuildContext context) {
    return ObxValue((Rx<currentSearchState> state) {
      switch (state.value) {
        case currentSearchState.idle:
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const Text("Search for anything")],
            ),
          );

        case currentSearchState.searching:
          return const Center(child: CircularProgressIndicator.adaptive());
        case currentSearchState.none:
          return const Center(child: Text("No such result"));
        case currentSearchState.error:
          return const Center(child: Text("Unknown Error"));
        case currentSearchState.done:
          return displaySearchResults();
        default:
          return Container();
      }
    }, controller.currentState);
  }

  Widget displaySearchResults() {
    List<Businesses> businesses = [];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: businessesChildren(businesses),
      ),
    );
  }

  businessesChildren(List<Businesses> businesses, BuildContext context) {
    return businesses.map((business) {
      //
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => BusinessDetailsView())));
          },
          child: ListTile(
            title: Text(business.location!),
            subtitle: Text(business.reviewsTotal!),
            leading: Text(business.starsAverage!),
          ),
        ),
      );
    }).toList();
  }
}
