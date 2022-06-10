import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:commerce/models/ModelProvider.dart';

enum CurrentSearchState { idle, searching, none, error, done }

class SearchController extends GetxController {
  Rx<CurrentSearchState> currentState = CurrentSearchState.idle.obs;
  RxString searchPhrase = ''.obs;
  RxInt searchperiod = 300.obs;
  RxString locationToBeSearched = ''.obs;
  Rx<SearchResult> searchResult =
      SearchResult(searchResult: [], businesses: []).obs;
  search() async {
    currentState.value = CurrentSearchState.searching;
    searchResult.value = await Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      currentState.value = CurrentSearchState.done;
      return fakeSearchResult();
    });
    // var result = await Amplify.DataStore.query(
    //   Users.classType,
    //   where: Users.NAME
    //       .beginsWith(searchPhrase.value)
    //       .and(Users.ISBUSINESS.eq(true)),
    // );
    // result.forEach((user) async {
    //   var res = await Amplify.DataStore.query(Businesses.classType,
    //       where: Businesses.ID.eq(user.id),
    //       pagination: const QueryPagination.firstResult());
    //   searchResult.add(res[0]);
    // });
    // currentState.value = CurrentSearchState.done;
  }

  SearchResult fakeSearchResult() {
    List<Users> searchresult = <Users>[];
    searchresult.addAll([
      Users(
        pics: const [
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://media.istockphoto.com/vectors/vector-illustration-of-red-house-icon-vector-id155666671?k=20&m=155666671&s=612x612&w=0&h=sL5gRpVmrGcZBVu5jEjF5Ne7A4ZrBCuh5d6DpRv3mps=',
          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/08/download-23.jpg'
        ],
        id: '54321',
        name: "Fadeke Hair Dressing",
        isBusiness: true,
        country: 'Nigeria',
        number: '5431',
        cac: 'sampleCAC',
      ),
      Users(
        pics: const [
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://media.istockphoto.com/vectors/vector-illustration-of-red-house-icon-vector-id155666671?k=20&m=155666671&s=612x612&w=0&h=sL5gRpVmrGcZBVu5jEjF5Ne7A4ZrBCuh5d6DpRv3mps=',
          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/08/download-23.jpg'
        ],
        id: '12345',
        name: "Fadeke Hair testing",
        isBusiness: true,
        country: 'Nigeria',
        number: '5431',
        cac: 'sampleCAC',
      ),
      Users(
        pics: const [
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://media.istockphoto.com/vectors/vector-illustration-of-red-house-icon-vector-id155666671?k=20&m=155666671&s=612x612&w=0&h=sL5gRpVmrGcZBVu5jEjF5Ne7A4ZrBCuh5d6DpRv3mps=',
          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/08/download-23.jpg'
        ],
        id: '9876',
        name: "Fadeke Hair Salon",
        isBusiness: true,
        country: 'Nigeria',
        number: '5431',
        cac: 'sampleCAC',
      ),
    ]);

    List<Businesses> businessResult = <Businesses>[];
    businessResult.addAll([
      Businesses(
          id: '54321',
          type: 'Hair Salon',
          location: 'Ilorin',
          about: 'we are a businesses that does things and other things',
          cac: '54321',
          AvailableDays: const [
            4,
            3,
            2
          ],
          availableTimes: const [
            '12:00- 14:00',
            '13:00- 16:00',
            '08:00-09:00'
          ]),
      Businesses(
          id: '12345',
          type: 'Hair Salon',
          location: 'Ilorin',
          about: 'we are a businesses that does things and other things',
          cac: '54321',
          AvailableDays: const [
            4,
            3,
            2
          ],
          availableTimes: const [
            '12:00- 14:00',
            '13:00- 16:00',
            '08:00-09:00'
          ]),
      Businesses(
          id: '9876',
          type: 'Hair Salon',
          location: 'Ilorin',
          about: 'we are a businesses that does things and other things',
          cac: '54321',
          AvailableDays: const [
            4,
            3,
            2
          ],
          availableTimes: const [
            '12:00 - 14:00',
            '13:00 - 16:00',
            '08:00 - 09:00'
          ]),
    ]);
    //location search
    if (locationToBeSearched.value.isNotEmpty) {
      businessResult = businessResult
          .where((element) =>
              element.location!.contains(locationToBeSearched.value))
          .toList();
      businessResult.forEach((business) {
        searchresult.retainWhere((users) => users.id == business.id);
      });
    }

// time search
    if (searchperiod.value != 300) {
      List<Businesses> updated = [];
      int starthrs = searchperiod.value;
      String timing = searchperiod.value.toString();
      if (starthrs < 10) {
        timing = '0$starthrs';
      }
      print('searching for $timing');
      businessResult.forEach((element) {
        bool contains = false;
        for (var time in element.availableTimes!) {
          List<String> splitItems = time.split(':');
          splitItems.addAll(splitItems[1].split('-'));
          splitItems.removeAt(1);
          print(splitItems);
          contains =
              splitItems[0].contains(timing) || splitItems[3].contains(timing);
          if (contains) {
            updated.add(element);
            break;
          }
        }
      });
      businessResult = updated;
    }
    return SearchResult(searchResult: searchresult, businesses: businessResult);
  }
}

// search ui
// profile ui
// booking ui
//dashboard search ui

class SearchResult {
  List<Users> searchResult;
  List<Businesses> businesses;
  SearchResult({
    required this.searchResult,
    required this.businesses,
  });
}

class GetDetails {
  Users current;
  Businesses business;
  GetDetails({required this.current, required this.business});
}
