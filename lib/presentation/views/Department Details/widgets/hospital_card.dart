import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  const HospitalCard({required this.hospital, super.key});

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
          // Hospital Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Container(
              height: 120.h,
              color: theme.colorScheme.primary.withOpacity(0.1),
              child: hospital.image == null
                  ? Icon(
                      FontAwesomeIcons.hospital,
                      size: 50.r,
                      color: theme.colorScheme.primary,
                    )
                  : Image.network(
                      hospital.image!,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(FontAwesomeIcons.hospital, size: 50.r),
                    ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hospital Name
                Text(
                  hospital.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Hospital Service
                Text(
                  hospital.service,
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
                        hospital.address,
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
                          hospital.appPrice.toString(),
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
                          hospital.phone,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Location Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    minimumSize: Size(double.infinity, 40.h),
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20.r,
                  ),
                  label: Text(
                    'عرض الموقع',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(hospital.locationUrl));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
