import 'package:flutter/material.dart';
import 'package:media_care/core/models/pharmacy_model.dart';
import 'package:media_care/presentation/views/home/widgets/custom_offer_item.dart';

class PharmacyListView extends StatelessWidget {
  PharmacyListView({super.key});
  final List<PharmacyModel> pharmacy = [
    PharmacyModel(image: 'assets/pharmacies/abdeen.jpg', title: 'Abdeen'),
    PharmacyModel(image: 'assets/pharmacies/Diamond.jpg', title: 'Diamond'),
    PharmacyModel(
        image: 'assets/pharmacies/IslamFathy.jpg', title: 'Eslam Fathy'),
    PharmacyModel(image: 'assets/pharmacies/elezaby.png', title: 'Elezaby'),
    PharmacyModel(image: 'assets/pharmacies/qady.png', title: 'El Qady'),
  ];
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
