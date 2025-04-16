import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Department/widgets/department_view.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo_impl.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import '../../Laboratories/Labs_view.dart';
import '../../Laboratories/manager/cubit/labs_cubit.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import '../../pharmacies/pharmacy_view.dart';

class CustomWrapContainersHomeView extends StatelessWidget {
  const CustomWrapContainersHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _FeatureItem(
        image: 'assets/pharmacies/pharmacy_icon.png',
        text: 'الصيدليات',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => PharmacyCubit(PharmacyRepoImpl(Dio())),
              child: PharmacyView(),
            );
          }));
        },
      ),
      _FeatureItem(
        image: 'assets/pharmacies/labs.png',
        text: 'المعامل',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => LaboratoryCubit(LaboratoryRepoImpl(Dio())),
              child: LaboratoryView(),
            );
          }));
        },
      ),
      _FeatureItem(
        image: 'assets/pharmacies/doctors_icon.png',
        text: 'الأقسام الطبية',
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DepartmentsView()));
        },
      ),
      // _FeatureItem(
      //   image: 'assets/pharmacies/blogs.jfif',
      //   text: 'المقالات الطبية',
      //   onTap: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => DoctorBlogsView()));
      //   },
      // ),
      // _FeatureItem(
      //   image: 'assets/offers/offer.png',
      //   text: 'العروض الطبية',
      //   onTap: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => OfferGroupView()));
      //   },
      // ),
    ];

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 20.h,
          childAspectRatio: 3.5, // حجم الكرت
        ),
        itemBuilder: (context, index) {
          return _AnimatedFeatureCard(item: items[index], delay: index * 100);
        },
      ),
    );
  }
}

class _FeatureItem {
  final String image;
  final String text;
  final VoidCallback onTap;

  _FeatureItem({
    required this.image,
    required this.text,
    required this.onTap,
  });
}

class _AnimatedFeatureCard extends StatefulWidget {
  final _FeatureItem item;
  final int delay;

  const _AnimatedFeatureCard({
    required this.item,
    required this.delay,
  });

  @override
  State<_AnimatedFeatureCard> createState() => _AnimatedFeatureCardState();
}

class _AnimatedFeatureCardState extends State<_AnimatedFeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Hero(
                tag: widget.item.image,
                child: Image.asset(
                  widget.item.image,
                  width: 45.w,
                  height: 45.h,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  widget.item.text,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.sp,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
