import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/widgets/clip_path.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/pharmacy_model.dart';
import 'pharmacy_details_page.dart';

class PharmacyListViewItem extends StatelessWidget {
  const PharmacyListViewItem({
    super.key,
    required this.pharmacy,
    required this.index,
  });
  final int index;
  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PharmacyDetailsPage(index: index, pharmacy: pharmacy),
            ),
          );
        },
        child: PharmacyListViewItemCard(pharmacy: pharmacy));
  }
}

class PharmacyListViewItemCard extends StatelessWidget {
  const PharmacyListViewItemCard({
    super.key,
    required this.pharmacy,
  });

  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
              child: pharmacy.image == null
                  ? Image.asset(
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      'assets/pharmacies/pharmacy_icon.png')
                  : Image.network(
                      pharmacy.image!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacy.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '${pharmacy.city} - ${pharmacy.area}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  pharmacy.service,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone,
                color: Theme.of(context).colorScheme.primary, size: 30),
            onPressed: () {
              launchDialer(pharmacy.phone);
            },
          ),
        ],
      ),
    );
  }
}

class CustomCardSimilarToWeb extends StatelessWidget {
  const CustomCardSimilarToWeb({
    super.key,
    required this.pharmacy,
  });

  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundDark.withOpacity(0.5),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(children: [
        ClipPath(
          clipper: ContainerClipper(),
          child: Container(
            height: 200.h,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20.h),
            Text(
              pharmacy.title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: pharmacy.image == null
                    ? Image.asset(
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                        'assets/pharmacies/pharmacy_icon.png')
                    : Image.network(
                        pharmacy.image!,
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      )),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 35.h),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Icon(Icons.location_on,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 30.sp),
                  onPressed: () {
                    launchCustomUrl(context, '${pharmacy.locationUrl}');
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 35.h),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text('المزيد',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary)),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PharmacyDetailsPage(
                                index: 0, pharmacy: pharmacy),
                          ),
                        )),
              ],
            ),
          ],
        ),
        Positioned(
          right: 20.w,
          bottom: 40.h,
          child: Text(' ${pharmacy.city} - ${pharmacy.area}',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        if (pharmacy.deliveryOption == 1)
          Positioned(
              left: 20.w,
              bottom: 70.h,
              child: Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  ' نوصيل 🚓',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              )),
      ]),
    );
  }
}
