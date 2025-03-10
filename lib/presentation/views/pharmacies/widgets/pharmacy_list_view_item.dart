import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/widgets/clip_path.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../../../../core/utils/app_color.dart';
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
        child: CustomCard(pharmacy: pharmacy));
  }
}

class CustomCard2 extends StatelessWidget {
  const CustomCard2({
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
            icon: Icon(Icons.phone, color: AppColors.primary, size: 30),
            onPressed: () {
              launchDialer(pharmacy.phone);
            },
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            color: AppColors.primary2,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20.h),
            Text(
              pharmacy.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                    backgroundColor: AppColors.primary2,
                  ),
                  child: Icon(Icons.location_on, color: Colors.white, size: 30),
                  onPressed: () {
                    launchCustomUrl(context, '${pharmacy.locationUrl}');
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 35.h),
                      backgroundColor: AppColors.primary2,
                    ),
                    child: Text('المزيد',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        )),
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
              style: TextStyle(color: AppColors.darkGrey, fontSize: 14.sp)),
        ),
        if (pharmacy.deliveryOption == 1)
          Positioned(
              left: 20.w,
              bottom: 70.h,
              child: Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary2,
                  ),
                ),
              )),
      ]),
    );
  }
}
