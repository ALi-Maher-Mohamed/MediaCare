import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'blog_item.dart';

class BlogList extends StatelessWidget {
  final List<Blog> blogs;

  const BlogList({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return BlogItem(blog: blog);
      },
    );
  }
}
