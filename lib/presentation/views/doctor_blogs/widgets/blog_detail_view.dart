import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

class BlogDetailsScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailsScreen({super.key, required this.blog});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          blog.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog.doctor.image,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                blog.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'بقلم د ${blog.doctor.fName} ${blog.doctor.lName}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 10.h),
              Text(
                blog.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
