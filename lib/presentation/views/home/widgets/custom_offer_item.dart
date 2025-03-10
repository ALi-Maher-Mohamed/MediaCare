// import 'package:flutter/material.dart';
// import 'package:media_care/core/utils/app_color.dart';
// import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
// import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_details_page.dart';

// class CustomListViewItem extends StatelessWidget {
//   CustomListViewItem(
//       {super.key,
//       required this.image,
//       required this.title,
//       required this.index,
//       required this.pharmacy});
//   final String image;
//   final String title;
//   final int index;
//   final PharmacyModel pharmacy;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return PharmacyDetailsPage(
//             index: index,
//             pharmacy: pharmacy,
//           );
//         }));
//       },
//       child: Column(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12), // تحديد الحواف الدائرية
//             child: Image.network(
//               image,
//               cacheWidth: 500,
//               cacheHeight: 500,
//               height: 100,
//               width: 100, // تحديد العرض أيضًا لجعلها دائرية تمامًا
//               fit: BoxFit.cover, // لجعل الصورة تغطي المساحة بشكل مناسب
//             ),
//           ),
//           SizedBox(height: 12),
//           Text(
//             title,
//             style: TextStyle(
//               color: AppColors.primary,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
