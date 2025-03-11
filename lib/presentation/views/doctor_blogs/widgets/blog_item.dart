import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  // DoctorBlogsApp(),
                  BlogDetailsScreen(
                    blog: blog,
                  )),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blog.doctor.image,
                    width: 80.w, height: 80.h, fit: BoxFit.cover),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(blog.title,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold)),
                    Text('by ' + blog.doctor.fName,
                        style: TextStyle(color: AppColors.primary)),
                    SizedBox(height: 5.h),
                    Text(blog.content,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogDetailsScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailsScreen({super.key, required this.blog});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Text(blog.title, style: TextStyle(color: AppColors.primary)),
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
                child: Image.network(blog.doctor.image,
                    width: double.infinity, height: 200.h, fit: BoxFit.fill),
              ),
              SizedBox(height: 10.h),
              Text(blog.title,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold)),
              Text('بقلم د ' + blog.doctor.fName + ' ' + blog.doctor.lName,
                  style: TextStyle(color: AppColors.darkGrey, fontSize: 16.sp)),
              SizedBox(height: 10.h),
              Text(blog.content, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
