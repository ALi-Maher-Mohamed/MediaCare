import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentItem extends StatelessWidget {
  final String iconUrl;
  final String title;

  const DepartmentItem({
    Key? key,
    required this.iconUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(25.sp),
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            iconUrl,
            height: 60.h,
            width: 60.w,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error,
                  size: 50.sp, color: Theme.of(context).colorScheme.error);
            },
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
