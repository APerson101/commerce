import 'package:commerce/models/Businesses.dart';
import 'package:commerce/views/main_controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../business_details/business_details.dart';

class SearchDashboard extends StatelessWidget {
  SearchDashboard({Key? key}) : super(key: key);
  final DashBoardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ObxValue((Rx<searchstatus> currentSearch) {
          switch (currentSearch.value) {
            case searchstatus.searching:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case searchstatus.done:
              return searchContent(
                controller.searchResultBusinesses,
                context,
              );
            default:
              return Container();
          }
        }, controller.currentSearchStatus));
  }

  Widget searchContent(
    RxList<Businesses> searchResultBusinesses,
    BuildContext context,
  ) {
    if (searchResultBusinesses.isEmpty) {
      return const Center(child: Text("No such result"));
    } else {
      return displaySearchResults(context, searchResultBusinesses);
    }
  }

  Widget displaySearchResults(
    BuildContext context,
    List<Businesses> businesses,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: businessesChildren(businesses, context),
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
            //TODO: FIX THIS, I HAVE IT UNDONE FOR NOW
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: ((context) =>
            //         BusinessDetailsView(selectedBusiness: business))));
          },
          child: ListTile(
            title: Text(business.location!),
            subtitle: Text(business.about!),
          ),
        ),
      );
    }).toList();
  }
}
