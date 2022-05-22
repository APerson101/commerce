import 'package:commerce/controllers/main_controller.dart';
import 'package:commerce/views/business_details/business_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../reviews_page_view.dart';

class BusinessDetailsView extends StatelessWidget {
  BusinessDetailsView({Key? key}) : super(key: key);
  final BusinessDetailsController controller =
      Get.put(BusinessDetailsController());
  final MainController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: controller.getDetails(_controller.user!.userId),
          builder: (context, AsyncSnapshot<BusinessDetailsModel> snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: mapChildren(snapshot.data!, context),
              ),
            );
          }),
    );
  }

  List<Widget> mapChildren(BusinessDetailsModel details, BuildContext context) {
    //Image carousal
    var imageCarousal = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: details.images
              .map((image) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(image: ''),
                    ),
                  ))
              .toList()),
    );

    //Row of name, about, etc
    var nameText = Text(details.name);

    var about = Text(details.business.about!);

    var location = Text(details.business.location!);
    var type = Text(details.business.type!);
    RxInt selectedDay = 0.obs;
    RxString selectedTime = ''.obs;
    //booking button
    RxString currentViewDay = 'day'.obs;
    var bookButton = ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
              content: ObxValue((RxString selection) {
            if (selection.value == 'day') {
              return SingleChildScrollView(
                  child: Column(
                      children: getAvailableDays().map((day) {
                switch (day) {
                  case 1:
                    return GestureDetector(
                      onTap: () {
                        currentViewDay.value = 'time';
                        selectedDay.value = day;
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(child: Text('Sunday')),
                      ),
                    );
                  case 2:
                    return GestureDetector(
                      onTap: () {
                        currentViewDay.value = 'time';

                        selectedDay.value = day;
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(child: Text('Monday')),
                      ),
                    );
                  case 3:
                    return GestureDetector(
                      onTap: () {
                        currentViewDay.value = 'time';

                        selectedDay.value = day;
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(child: Text('Tuesday')),
                      ),
                    );
                  case 4:
                    return GestureDetector(
                      onTap: () {
                        currentViewDay.value = 'time';

                        selectedDay.value = day;
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(child: Text('Wednesday')),
                      ),
                    );
                  case 5:
                    return GestureDetector(
                        onTap: () {
                          currentViewDay.value = 'time';

                          selectedDay.value = day;
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(child: Text('Thursday'))));
                  case 6:
                    return GestureDetector(
                        onTap: () {
                          currentViewDay.value = 'time';

                          selectedDay.value = day;
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(child: Text('Friday'))));
                  case 7:
                    return GestureDetector(
                        onTap: () {
                          currentViewDay.value = 'time';

                          selectedDay.value = day;
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(child: Text('Saturday'))));
                  default:
                    return const Text('');
                }
              }).toList()));
            } else if (selection.value == 'time') {
              return SingleChildScrollView(
                child: Column(
                  children: getAvailableTimes(4)
                      .map((time) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () async {
                              selectedTime.value = time;
                              await Get.defaultDialog(
                                  content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: const Text("Confirm Booking?"),
                                  ),
                                  onConfirm: () async {
                                    bool status =
                                        await controller.confirmBooking(
                                            selectedTime.value,
                                            selectedDay.value);
                                    if (status) {
                                      Get.back();
                                      Get.snackbar(
                                          'confirmation', "booking confirmed");
                                    }
                                  });
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(time)),
                          )))
                      .toList(),
                ),
              );
            } else if (selection.value == 'loading') {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const Center(child: Text("Unable to complete"));
            }
          }, currentViewDay));
        },
        child: const Text("Book now"));

    var viewReviews = ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ReviewsPageView(reviews: details.allReviews)));
        },
        child: const Text("Reviews"));

    List<Widget> all = [];
    all.add(imageCarousal);
    all.add(nameText);
    all.add(about);
    all.add(location);
    all.add(type);
    all.add(bookButton);
    //next tab for reviews
    return all;
  }

  List<Meeting> getMeetings() {
    List<Meeting> all = [];
    all.add(
        Meeting('businessName', DateTime.now(), DateTime.now(), Colors.red));
    return all;
  }
}

List<String> getAvailableTimes(int day) {
  //
  return ['8:00AM- 9:00AM', '10:00AM- 11:00AM', '2:00PM- 4:00pM'];
}

List<int> getAvailableDays() {
  return [1, 3, 5];
}

class BookingsSource extends CalendarDataSource {
  List<Meeting> allMettings;
  BookingsSource({required this.allMettings});
}

class Meeting {
  Meeting(this.businessName, this.from, this.to, this.background);

  String businessName;
  DateTime from;
  DateTime to;
  Color background;
}
