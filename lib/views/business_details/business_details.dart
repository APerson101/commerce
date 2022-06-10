import 'package:commerce/views/business_details/business_details_controller.dart';
import 'package:commerce/views/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../main_controllers/search_controller.dart';
import '../reviews_page_view.dart';
import 'buss_details_page.dart';

class BusinessDetailsView extends ConsumerWidget {
  BusinessDetailsView({Key? key, required this.selectedBusiness})
      : super(key: key);
  final BusinessDetailsController controller =
      Get.put(BusinessDetailsController());
  // final MainController _controller = Get.find();
  GetDetails selectedBusiness;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(getFakedetailsProvider(selectedBusiness));
    // final loader = ref.watch(getDetailsProvider(_controller.user.userId));
    return loader.when(data: (BusinessDetailsModel data) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  onStretchTrigger: () {
                    // Function callback for stretch
                    return Future<void>.value();
                  },
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: ,
                    stretchModes: const <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    background: Column(children: [
                      Image.network(data.images[0],
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.fill),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24),
                        child: Row(children: [
                          Text(data.name),
                          const Spacer(),
                          const FaIcon(FontAwesomeIcons.heart)
                        ]),
                      ),
                      const TabBar(tabs: [
                        Tab(text: 'Services'),
                        Tab(text: 'Reviews'),
                        Tab(text: 'Details'),
                      ]),
                    ]),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(children: [
                      ServicesPaegBusiness(business: data),
                      ReviewsPageView(reviews: data.allReviews),
                      BusDetailsPage(business: data)
                    ]),
                  ),
                ]))
              ],
            ),
          ));
    }, error: (Object error, StackTrace? stackTrace) {
      //
      return const Scaffold(
        body: Center(child: Text("Unknown Error")),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    });
  }
}
