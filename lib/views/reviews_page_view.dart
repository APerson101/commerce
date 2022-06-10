import 'package:commerce/models/Reviews.dart';
import 'package:flutter/material.dart';

class ReviewsPageView extends StatelessWidget {
  ReviewsPageView({Key? key, required this.reviews}) : super(key: key);
  List<Reviews> reviews;

  @override
  Widget build(BuildContext context) {
    int total_reviews = reviews.length;
    int total_one_star =
        reviews.where((review) => review.stars == 1).toList().length;
    int total_two_star =
        reviews.where((review) => review.stars == 2).toList().length;
    int total_three_star =
        reviews.where((review) => review.stars == 3).toList().length;
    int total_four_star =
        reviews.where((review) => review.stars == 4).toList().length;
    int total_five_star =
        reviews.where((review) => review.stars == 5).toList().length;
    int total_stars = 0;
    reviews.forEach((review) => total_stars += review.stars!);
    double avg = (total_stars / (total_reviews * 5));
    ;
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListTile(
                    title: Text('$avg / 5'),
                    subtitle: Text('$total_reviews Review(s)'),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    ...[5, 4, 3, 2, 1].map((number) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('$number'),
                            const SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width: 100,
                              child: LinearProgressIndicator(
                                value: number / 5,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.yellow.shade600),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                '${reviews.where((review) => review.stars == 1).toList().length}'),
                            const SizedBox(
                              width: 3,
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  ]),
                ),
              )
            ],
          ),
        ),
        ...reviews.map((review) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Text(review.stars!.toString()),
                title: Text(review.comment!),
              ),
            ),
          );
        }).toList()
      ]),
    );
  }
}
