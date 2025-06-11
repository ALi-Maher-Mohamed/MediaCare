// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../search/search_view.dart';

// class SearchDoctor extends StatelessWidget {
//   const SearchDoctor({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context)
//             .colorScheme
//             .surface, // تعديل: استخدام surface من الـ Theme بدل lightGrey
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'أكتشف المزيد !',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     // تعديل: استخدام titleLarge من الـ Theme
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             SizedBox(
//               height: 12.h,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return SearchView();
//                 }));
//               },
//               child: Container(
//                 height: 50.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: Theme.of(context)
//                           .primaryColor), // تعديل: استخدام primaryColor من الـ Theme
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 12.w,
//                     ),
//                     Text(
//                       'ابحث بالتخصص او باسم الدكتور',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             // تعديل: استخدام bodyMedium من الـ Theme
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 14.sp,
//                           ),
//                     ),
//                     Spacer(),
//                     Icon(
//                       Icons.search,
//                       color: Theme.of(context)
//                           .primaryColor, // تعديل: استخدام primaryColor من الـ Theme
//                     ),
//                     SizedBox(
//                       width: 12.w,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
