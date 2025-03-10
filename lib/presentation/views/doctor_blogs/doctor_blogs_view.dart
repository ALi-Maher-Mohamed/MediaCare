// view/doctor_blogs_view.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo_impl.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_state.dart';

class DoctorBlogsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المقالات الطبية')),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) =>
              DoctorBlogsCubit(BlogsRepoImpl(Dio()))..fetchBlogs(),
          child: BlocBuilder<DoctorBlogsCubit, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is BlogError) {
                return Center(child: Text(state.message));
              }

              if (state is BlogLoaded) {
                if (state.blogs.isEmpty) {
                  return Center(child: Text('لا توجد مقالات متاحة'));
                }
                return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(blog.doctor.image),
                        ),
                        title: Text(blog.title),
                        subtitle: Text(
                          '${blog.doctor.fName} ${blog.doctor.lName} - ${blog.createdAt.toString().substring(0, 10)}',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlogDetailScreen(blog: blog),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }

              return Center(child: Text('اضغط لجلب البيانات'));
            },
          ),
        ),
      ),
    );
  }
}

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  BlogDetailScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(blog.title)),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('بقلم: ${blog.doctor.fName} ${blog.doctor.lName}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('التاريخ: ${blog.createdAt.toString().substring(0, 10)}'),
                SizedBox(height: 16),
                Text(blog.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
