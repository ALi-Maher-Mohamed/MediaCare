import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: CustomCard2(pharmacy: pharmacy));
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
            color: AppColors.primaryLight,
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
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.green, size: 50),
                  onPressed: () {
                    launchDialer(pharmacy.phone);
                  },
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
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
                IconButton(
                  icon: Icon(Icons.location_on, color: Colors.green, size: 50),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              pharmacy.area,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ContainerClipper extends CustomClipper<Path> {
  var path = Path();
  @override
  Path getClip(Size size) {
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(size.width * 0.25, size.height - 75, size.width * .5,
        size.height - 110);
    path.quadraticBezierTo(
        size.width * 0.8, size.height - 100, size.width, size.height - 80);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
