import 'package:flutter/material.dart';
import '../data/model/pharmacy_model.dart';

class PharmacyCardsListView extends StatelessWidget {
  final List<PharmacyModel> pharmacies;
  const PharmacyCardsListView({
    super.key,
    required this.pharmacies,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        PharmacyModel pharmacy = pharmacies[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(pharmacy.image,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(pharmacy.title),
            subtitle: Text(
                '${pharmacy.city} - ${pharmacy.area}\n${pharmacy.service}'),
            trailing: IconButton(
              icon: Icon(Icons.phone, color: Colors.green),
              onPressed: () {
                // تنفيذ الاتصال عند الضغط على الزر
              },
            ),
          ),
        );
      },
    );
  }
}
