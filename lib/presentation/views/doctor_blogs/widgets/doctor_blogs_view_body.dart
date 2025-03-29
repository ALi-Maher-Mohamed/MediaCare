import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';
import 'package:media_care/presentation/views/doctor_blogs/widgets/blog_list.dart';

class DoctorBlogsViewBody extends StatelessWidget {
  const DoctorBlogsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBlogsCubit, BlogState>(
      builder: (context, state) {
        if (state is BlogLoadingState) {
          return const CustomProgressIndicator();
        }
        if (state is BlogErrorState) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          );
        }
        if (state is BlogSuccessState) {
          if (state.blogs.isEmpty) {
            return Center(
              child: Text(
                'لا توجد مقالات متاحة',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            );
          }
          return BlogList(blogs: state.blogs);
        }
        return Center(
          child: Text(
            'اضغط لجلب البيانات',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        );
      },
    );
  }
}
