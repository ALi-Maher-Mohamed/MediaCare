import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/models/doctor_blogs_model.dart';
import 'package:media_care/presentation/views/doctor_blogs/widgets/blog_detail_view.dart';

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
            builder: (context) => BlogDetailsScreen(blog: blog),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
        clipBehavior:
            Clip.antiAliasWithSaveLayer, // يمنع تجاوز الصورة لحدود البطاقة
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog.doctor.image,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'by ${blog.doctor.fName}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      blog.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
