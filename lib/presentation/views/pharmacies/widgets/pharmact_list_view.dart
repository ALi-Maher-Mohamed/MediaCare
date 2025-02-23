import 'package:flutter/material.dart';
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

class PharmacyListViewItem extends StatelessWidget {
  const PharmacyListViewItem({
    super.key,
    required this.pharmacy,
  });

  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyDetailsPage(pharmacy: pharmacy),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                pharmacy.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pharmacy.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pharmacy.city} - ${pharmacy.area}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pharmacy.service,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.phone, color: Colors.green, size: 30),
              onPressed: () {
                // تنفيذ الاتصال عند الضغط على الزر
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PharmacyDetailsPage extends StatelessWidget {
  final PharmacyModel pharmacy;
  const PharmacyDetailsPage({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacy.title),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  pharmacy.image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "📍 الموقع: ${pharmacy.city}, ${pharmacy.area}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "🛠️ الخدمة المقدمة: ${pharmacy.service}",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // تنفيذ الاتصال عند الضغط
                },
                icon: Icon(Icons.phone),
                label: Text("اتصل بالصيدلية"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
