import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/labs_model/data.dart';

class LaboratoryDetailsPage extends StatelessWidget {
  final LaboratoryModel laboratory;
  const LaboratoryDetailsPage({super.key, required this.laboratory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          laboratory.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/pharmacies/labs.png',
                  ),
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Text(
              "🛠️ الخدمات المقدمة: ${laboratory.service}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Text(
              "⭐ التقييم: ${laboratory.avgRate} / 5.0",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElevatedButton.icon(
                  onPressed: () => launchDialer(laboratory.phone),
                  icon: Icon(Icons.phone,
                      color: Theme.of(context).colorScheme.primary),
                  label: Text(
                    "اتصل بالمعمل",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () =>
                      launchCustomUrl(context, laboratory.locationUrl),
                  icon: Icon(Icons.map,
                      color: Theme.of(context).colorScheme.primary),
                  label: Text(
                    "عرض على الخريطة",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () =>
                      launchCustomUrl(context, laboratory.whatsappLink),
                  icon: FaIcon(FontAwesomeIcons.whatsapp,
                      color: Theme.of(context).colorScheme.primary),
                  label: Text(
                    "واتساب",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
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
