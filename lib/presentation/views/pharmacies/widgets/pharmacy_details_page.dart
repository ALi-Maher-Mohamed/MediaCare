import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/pharmacy_model.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final PharmacyModel pharmacy;
  final int index;
  const PharmacyDetailsPage(
      {super.key, required this.index, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        centerTitle: true,
        title: Text(
          pharmacy.title,
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
                    pharmacy.image ??
                        'https://cdn4.vectorstock.com/i/1000x1000/62/78/error-sign-icon-image-vector-16746278.jpg',
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(height: 50),
            Text(
              "📍 الموقع: ${pharmacy.city}, ${pharmacy.area}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              "🛠️ الخدمة المقدمة: ${pharmacy.service}",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 30),
            Text(
              "⭐ التقييم: ${pharmacy.avgRate} / 5.0",
              style: TextStyle(fontSize: 16, color: Colors.amber),
            ),
            const SizedBox(height: 30),
            Text(
              "🚚 التوصيل: ${pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح"}",
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 30),
            Text(
              "🛡️ التأمين الصحي: ${pharmacy.insurence == 1 ? "مدعوم" : "غير مدعوم"}",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElevatedButton.icon(
                  onPressed: () => launchDialer('01278408531'),
                  icon: Icon(Icons.phone, color: AppColors.primary),
                  label: Text(
                    "اتصل بالصيدلية",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGrey,
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => launchCustomUrl(
                      context, 'https://goo.gl/maps/y9b6HrD4CzN2'),
                  icon: Icon(Icons.map, color: AppColors.primary),
                  label: Text(
                    "عرض على الخريطة",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGrey,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () =>
                      launchCustomUrl(context, 'https://wa.me/201278408531'),
                  icon: FaIcon(FontAwesomeIcons.whatsapp,
                      color: AppColors.primary),
                  label: Text(
                    "واتساب",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGrey,
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
