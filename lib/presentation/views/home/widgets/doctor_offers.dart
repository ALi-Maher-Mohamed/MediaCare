// import 'package:flutter/material.dart';
// import '../../../../core/models/doc_offer_model.dart';
// import 'custom_offer_item.dart';

// class DoctorsOffers extends StatelessWidget {
//   DoctorsOffers({super.key});
//   final List<DocOfferModel> offers = [
//     DocOfferModel(
//       image: 'assets/offers/eye.jpg',
//       title: 'Eyes',
//     ),
//     DocOfferModel(
//       image: 'assets/offers/scan.jpeg',
//       title: 'Skin',
//     ),
//     DocOfferModel(
//       image: 'assets/offers/scan2.jpg',
//       title: 'Scaning',
//     ),
//     DocOfferModel(
//       image: 'assets/offers/teeth2.jpg',
//       title: 'Teeth',
//     ),
//     DocOfferModel(
//       image: 'assets/offers/teeth3.jpg',
//       title: 'Braces',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: offers.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
//             child: CustomListViewItem(
//               image: offers[index].image,
//               title: offers[index].title,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
