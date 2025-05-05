import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo_impl.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';
import 'package:media_care/presentation/views/doctor_blogs/widgets/blog_detail_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dio/dio.dart';

class BlogsRow extends StatelessWidget {
  const BlogsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorBlogsCubit(
        BlogsRepoImpl(ApiServiceFunctions(Dio())),
      )..fetchBlogs(),
      child: BlocBuilder<DoctorBlogsCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Shimmer.fromColors(
                      baseColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.6),
                      highlightColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.8),
                      child: Column(
                        children: [
                          Container(
                            width: 110.w,
                            height: 110.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 90.w,
                            height: 16.h,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BlogSuccessState) {
            final blogs = state.blogs;
            if (blogs.isEmpty) {
              return SizedBox(
                height: 150.h,
                child: Center(child: Text('لا توجد مقالات متاحة')),
              );
            }
            return SizedBox(
              height: 160.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailsScreen(blog: blog),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Column(
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: blog.doctor.image,
                                  width: 120.w,
                                  height: 120.h,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                          SizedBox(height: 8.h),
                          FittedBox(
                            child: Text(
                              blog.doctor.fName + " " + blog.doctor.lName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BlogErrorState) {
            return SizedBox(
              height: 150.h,
              child: Center(child: Text(state.message)),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
