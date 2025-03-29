import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/utils/widgets/clip_path.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';

class CareCenterCard extends StatelessWidget {
  final CareCenter careCenter;
  const CareCenterCard({required this.careCenter, super.key});

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
            height: 250.h,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.h),
            FaIcon(
              FontAwesomeIcons.hospital,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Text(
              careCenter.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            Text(
              careCenter.service,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            SizedBox(height: 20.h),
            ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: careCenter.image == null
                    ? Image.asset(
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                        'assets/pharmacies/pharmacy_icon.png')
                    : Image.network(
                        careCenter.image!,
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      )),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Text(
                    '${careCenter.appPrice}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  FaIcon(
                    FontAwesomeIcons.moneyBill,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    careCenter.phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  FaIcon(
                    FontAwesomeIcons.phone,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                careCenter.address,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(270.w, 35.h),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {}),
          ],
        ),
      ]),
    );
  }
}
