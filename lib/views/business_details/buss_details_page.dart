import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business_details_controller.dart';

class BusDetailsPage extends ConsumerWidget {
  const BusDetailsPage({Key? key, required this.business}) : super(key: key);
  final BusinessDetailsModel business;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(business.name),
          Text(business.business.about!),
          Text(business.user.number!),
        ],
      ),
    );
  }
}
