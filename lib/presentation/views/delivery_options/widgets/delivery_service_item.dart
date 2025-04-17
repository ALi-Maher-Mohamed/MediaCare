import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import '../data/models/delivery_service_model.dart';

class DeliveryServiceItem extends StatelessWidget {
  final DeliveryServiceModel service;
  final int index;

  const DeliveryServiceItem({
    super.key,
    required this.service,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // أيقونة افتراضية
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_shipping,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30.w,
                ),
              ),
              SizedBox(width: 16.w),
              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 18.sp,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // زر الرابط
              ElevatedButton.icon(
                onPressed: () {
                  launchCustomUrl(context, service.appLink);
                },
                icon: Icon(
                  Icons.link,
                  size: 18.w,
                ),
                label: Text(
                  'زيارة',
                  style: TextStyle(fontSize: 14.sp),
                ),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
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
