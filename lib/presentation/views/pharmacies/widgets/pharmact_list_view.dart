import 'package:flutter/material.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_details_page.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_list_view_item.dart';
import '../data/model/pharmacy_model.dart';

class PharmacyCardsListView extends StatefulWidget {
  final List<PharmacyModel> pharmacies;
  const PharmacyCardsListView({super.key, required this.pharmacies});

  @override
  _PharmacyCardsListViewState createState() => _PharmacyCardsListViewState();
}

class _PharmacyCardsListViewState extends State<PharmacyCardsListView> {
  int currentPage = 0;
  final int itemsPerPage = 5; // عدد الصيدليات في كل صفحة

  @override
  Widget build(BuildContext context) {
    // حساب بداية ونهاية العناصر في الصفحة الحالية
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    endIndex = (endIndex > widget.pharmacies.length)
        ? widget.pharmacies.length
        : endIndex;

    List<PharmacyModel> currentPharmacies =
        widget.pharmacies.sublist(startIndex, endIndex);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: currentPharmacies.length,
            itemBuilder: (context, index) {
              PharmacyModel pharmacy = currentPharmacies[index];
              return PharmacyListViewItem(pharmacy: pharmacy);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                child: Text("السابق"),
              ),
              Text(
                "صفحة ${currentPage + 1} من ${((widget.pharmacies.length / itemsPerPage).ceil())}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: endIndex < widget.pharmacies.length
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
                child: Text("التالي"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class PharmacyDetailsPage extends StatelessWidget {
//   final PharmacyModel pharmacy;
//   const PharmacyDetailsPage({super.key, required this.pharmacy});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: AppColors.primary),
//         centerTitle: true,
//         title: Text(
//           pharmacy.title,
//           style: TextStyle(color: AppColors.primary),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   pharmacy.image,
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "📍 الموقع: ${pharmacy.city}, ${pharmacy.area}",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "🛠️ الخدمة المقدمة: ${pharmacy.service}",
//               style: TextStyle(fontSize: 16, color: Colors.blueGrey),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: () => launchDialer(pharmacy.phone),
//                 icon: Icon(Icons.phone),
//                 label: Text("اتصل بالصيدلية"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
