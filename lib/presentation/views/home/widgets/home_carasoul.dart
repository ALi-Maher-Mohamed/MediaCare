import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarousel extends StatelessWidget {
  final List<_CarouselItem> items = [
    _CarouselItem(
      backgroundUrl:
          'https://img.freepik.com/free-photo/doctor-with-stethoscope-hospital_1150-17858.jpg',
      title: 'احجز كشفك في ثواني!',
      subtitle: 'مع MediCare، الوصول للأطباء صار أسهل وأسرع.',
    ),
    _CarouselItem(
      backgroundUrl:
          'https://img.freepik.com/free-photo/medical-banner-with-doctor-wearing-coat_23-2149611199.jpg',
      title: 'قيم تجربتك مع الطبيب',
      subtitle: 'نظام تقييم شفاف يساعدك تختار الأفضل.',
    ),
    _CarouselItem(
      backgroundUrl:
          'https://img.freepik.com/free-photo/doctor-standing-with-arms-crossed-hospital_1150-17847.jpg',
      title: 'كل التخصصات في مكان واحد',
      subtitle: 'جراحين، أطفال، جلدية، والمزيد... كلهم في تطبيق واحد.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 3,
        // height: 80.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: items.map((item) {
        return Builder(
          builder: (context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.backgroundUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 6, color: Colors.black)
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _CarouselItem {
  final String backgroundUrl;
  final String title;
  final String subtitle;

  _CarouselItem({
    required this.backgroundUrl,
    required this.title,
    required this.subtitle,
  });
}
