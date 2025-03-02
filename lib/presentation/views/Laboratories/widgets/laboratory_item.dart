import 'package:flutter/material.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import 'package:media_care/presentation/views/Laboratories/data/model/labs_model/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LaboratoryDetailsPage extends StatelessWidget {
  final LaboratoryModel laboratory;
  const LaboratoryDetailsPage({super.key, required this.laboratory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        centerTitle: true,
        title: Text(
          laboratory.title,
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
                  laboratory.image,
                  width: double.infinity,
                  height: 230,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "📍 الموقع: ${laboratory.city}, ${laboratory.area}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              "🛠️ الخدمات المقدمة: ${laboratory.service}",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 30),
            Text(
              "⭐ التقييم: ${laboratory.avgRate} / 5.0",
              style: TextStyle(fontSize: 16, color: Colors.amber),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElevatedButton.icon(
                  onPressed: () => launchDialer(laboratory.phone),
                  icon: Icon(Icons.phone, color: AppColors.primary),
                  label: Text(
                    "اتصل بالمعمل",
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
                  onPressed: () =>
                      launchCustomUrl(context, laboratory.locationUrl),
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
                      launchCustomUrl(context, laboratory.whatsappLink),
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
