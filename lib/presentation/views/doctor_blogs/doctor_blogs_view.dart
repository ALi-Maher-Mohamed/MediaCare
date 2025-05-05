import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo_impl.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/doctor_blogs/widgets/doctor_blogs_view_body.dart';

class DoctorBlogsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'المقالات الطبية',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) =>
              DoctorBlogsCubit(BlogsRepoImpl(ApiServiceFunctions(Dio())))
                ..fetchBlogs(),
          child: DoctorBlogsViewBody(),
        ),
      ),
    );
  }
}
