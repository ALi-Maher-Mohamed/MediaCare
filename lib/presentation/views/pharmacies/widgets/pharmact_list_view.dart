import 'package:flutter/material.dart';
import 'pharmacy_list_view_item.dart';
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
