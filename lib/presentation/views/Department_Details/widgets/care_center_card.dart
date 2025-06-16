import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import 'package:media_care/presentation/views/Department_Details/data/models/department_details_model.dart';

class CareCenterCard extends StatelessWidget {
  final CareCenter careCenter;
  const CareCenterCard({required this.careCenter, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Care Center Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Container(
              height: 120.h,
              color: theme.colorScheme.primary.withOpacity(0.1),
              child: careCenter.image == null
                  ? Icon(
                      FontAwesomeIcons.houseChimneyMedical,
                      size: 50.r,
                      color: theme.colorScheme.primary,
                    )
                  : Image.network(
                      careCenter.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                          FontAwesomeIcons.houseChimneyMedical,
                          size: 50.r),
                    ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center Name
                Text(
                  careCenter.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Center Service
                Text(
                  careCenter.service,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.h),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                      size: 20.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        careCenter.address,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Price and Phone Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: theme.colorScheme.primary,
                          size: 20.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          careCenter.appPrice.toString(),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),

                    // Phone
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: theme.colorScheme.primary,
                          size: 20.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          careCenter.phone,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Contact Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    minimumSize: Size(double.infinity, 40.h),
                  ),
                  onPressed: () {
                    // Implement contact functionality
                    launchDialer(careCenter.phone);
                  },
                  child: Text(
                    'اتصل الآن',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
