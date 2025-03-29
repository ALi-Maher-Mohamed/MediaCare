import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          pharmacy.title,
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Text(
              "🛠️ الخدمة المقدمة: ${pharmacy.service}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Text(
              "⭐ التقييم: ${pharmacy.avgRate} / 5.0",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Text(
              "🚚 التوصيل: ${pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح"}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Text(
              "🛡️ التأمين الصحي: ${pharmacy.insurence == 1 ? "مدعوم" : "غير مدعوم"}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElevatedButton.icon(
                  onPressed: () => launchDialer('01278408531'),
                  icon: Icon(Icons.phone,
                      color: Theme.of(context).colorScheme.primary),
                  label: Text(
                    "اتصل بالصيدلية",
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
                  onPressed: () => launchCustomUrl(
                      context, 'https://goo.gl/maps/y9b6HrD4CzN2'),
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
                      launchCustomUrl(context, 'https://wa.me/201278408531'),
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
