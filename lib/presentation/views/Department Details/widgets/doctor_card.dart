import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Doctor%20Details/doctor_details_view.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({required this.doctor, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsView(doctorID: doctor.id),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Doctor Image
              Container(
                width: 85.w,
                height: 85.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: doctor.image == null
                      ? Image.asset(
                          'assets/pharmacies/pharmacy_icon.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          doctor.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person, size: 40.r),
                        ),
                ),
              ),
              SizedBox(height: 8.h),

              // Doctor Name
              Text(
                "${doctor.fName} ${doctor.lName}",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),

              // Doctor Title
              Text(
                doctor.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Rating and Price Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.moneyBillWave,
                          color: theme.colorScheme.primary,
                          size: 18.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          doctor.appPrice.toString(),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),

                    // Phone
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.phone,
                          color: theme.colorScheme.primary,
                          size: 15.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          doctor.phone,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // Details Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  minimumSize: Size(double.infinity, 40.h),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DoctorDetailsView(doctorID: doctor.id),
                    ),
                  );
                },
                child: Text(
                  'عرض التفاصيل',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
