import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:commerce/models/ModelProvider.dart';
import 'package:get/get.dart';

enum currentSearchState { idle, searching, none, error, done }

class SearchController extends GetxController {
  Rx<currentSearchState> currentState = currentSearchState.idle.obs;
  RxString searchPhrase = ''.obs;
  RxList<Businesses> searchResult = <Businesses>[].obs;
  search() async {
    currentState.value = currentSearchState.searching;
    print('searching for ${searchPhrase.value}');
    var result = await Amplify.DataStore.query(
      Users.classType,
      where: Users.NAME
          .beginsWith(searchPhrase.value)
          .and(Users.ISBUSINESS.eq(true)),
    );
    result.forEach((user) async {
      var res = await Amplify.DataStore.query(Businesses.classType,
          where: Businesses.ID.eq(user.id),
          pagination: const QueryPagination.firstResult());
      searchResult.add(res[0]);
    });
    if (searchResult.isNotEmpty) {
      currentState.value = currentSearchState.done;
    } else {
      currentState.value = currentSearchState.error;
    }
  }
}
