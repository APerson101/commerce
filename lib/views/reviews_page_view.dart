import 'package:commerce/models/Reviews.dart';
import 'package:flutter/material.dart';

class ReviewsPageView extends StatelessWidget {
  ReviewsPageView({Key? key, required this.reviews}) : super(key: key);
  List<Reviews> reviews;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: reviews.map((review) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Text(review.stars!.toString()),
              title: Text(review.comment!),
            ),
          ),
        );
      }).toList()),
    );
  }
}
