import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo_impl.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/doctor_blogs/widgets/doctor_blogs_view_body.dart';

class DoctorBlogsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text('المقالات الطبية',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) =>
              DoctorBlogsCubit(BlogsRepoImpl(Dio()))..fetchBlogs(),
          child: DoctorBlogsViewBody(),
        ),
      ),
    );
  }
}
