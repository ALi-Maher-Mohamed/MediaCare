import 'package:flutter/material.dart';
import '../../pharmacies/data/model/pharmacy_model.dart';
import 'custom_offer_item.dart';

class PharmacyListView extends StatelessWidget {
  PharmacyListView({super.key, required this.pharmacy});
  final List<PharmacyModel> pharmacy;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pharmacy.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: CustomListViewItem(
              image: pharmacy[index].image,
              title: pharmacy[index].title,
            ),
          );
        },
      ),
    );
  }
}
