// import 'package:flutter/material.dart';

// class TimeSlotSelectionScreen extends StatefulWidget {
//   @override
//   _TimeSlotSelectionScreenState createState() =>
//       _TimeSlotSelectionScreenState();
// }

// class _TimeSlotSelectionScreenState extends State<TimeSlotSelectionScreen> {
//   PageController _pageController = PageController(initialPage: 0);

//   List<Map<String, dynamic>> dates = [
//     {
//       "date": "السبت 8 مارس",
//       "slots": ["2:00 مساء - 2:30 مساء", "2:30 مساء - 3:00 مساء"]
//     },
//     {
//       "date": "الأحد 9 مارس",
//       "slots": ["3:00 مساء - 3:30 مساء", "3:30 مساء - 4:00 مساء"]
//     },
//     {
//       "date": "الإثنين 10 مارس",
//       "slots": ["4:00 مساء - 4:30 مساء", "4:30 مساء - 5:00 مساء"]
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 300,
//           height: 200,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
//             ],
//           ),
//           child: Stack(
//             children: [
//               PageView.builder(
//                 controller: _pageController,
//                 itemCount: dates.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         dates[index]["date"],
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.cyan,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       ...dates[index]["slots"].map<Widget>((slot) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 20),
//                           child: Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 slot,
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.black),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ],
//                   );
//                 },
//               ),
//               Positioned(
//                 left: 5,
//                 top: 75,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back_ios, color: Colors.cyan),
//                   onPressed: () {
//                     _pageController.previousPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 right: 5,
//                 top: 75,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_forward_ios, color: Colors.cyan),
//                   onPressed: () {
//                     _pageController.nextPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
