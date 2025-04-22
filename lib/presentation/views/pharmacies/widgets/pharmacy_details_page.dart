import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: pharmacy.image == null
                      ? Image.asset(
                          'assets/Gifs/pharmacy.gif',
                          width: double.infinity,
                          height: 230.h,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          pharmacy.image!,
                          width: double.infinity,
                          height: 230.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/Gifs/pharmacy.gif',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                "📍 الموقع: ${pharmacy.city}, ${pharmacy.area}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 30.h),
              Text(
                "🛠️ الخدمة المقدمة: ${pharmacy.service}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              Text(
                "⭐ التقييم: ${pharmacy.avgRate} / 5.0",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              Text(
                "🚚 التوصيل: ${pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح"}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              Text(
                "🛡️ التأمين الصحي: ${pharmacy.insurence == 1 ? "مدعوم" : "غير مدعوم"}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
              Wrap(
                spacing: 20.w,
                runSpacing: 20.h,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => launchDialer(pharmacy.phone),
                    icon: Icon(Icons.phone,
                        color: Theme.of(context).colorScheme.primary),
                    label: Text(
                      "اتصل بالصيدلية",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () =>
                        launchCustomUrl(context, pharmacy.locationUrl),
                    icon: Icon(Icons.map,
                        color: Theme.of(context).colorScheme.primary),
                    label: Text(
                      "عرض على الخريطة",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () =>
                        launchCustomUrl(context, pharmacy.whatsappLink),
                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                        color: Theme.of(context).colorScheme.primary),
                    label: Text(
                      "واتساب",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
