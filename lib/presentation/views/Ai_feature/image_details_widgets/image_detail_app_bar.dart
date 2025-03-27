import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class ImageDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ImageDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.primary),
      centerTitle: true,
      title: Text(
        'تفاصيل الصورة',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      forceMaterialTransparency: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
