import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Laboratories/Labs_view.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo_impl.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/delivery_options/delivery_options_view.dart';
import 'package:media_care/presentation/views/doctor_blogs/doctor_blogs_view.dart';
import 'package:media_care/presentation/views/doctors_offers/offer_group_view.dart';
import 'package:media_care/presentation/views/home/widgets/blogs_row.dart';
import 'package:media_care/presentation/views/home/widgets/home_carasoul.dart';
import 'package:media_care/presentation/views/home/widgets/offers_row.dart';
import 'package:media_care/presentation/views/home/widgets/title_and_see_all.dart';
import 'package:media_care/presentation/views/home/widgets/wrap_container_home.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import 'package:media_care/presentation/views/profile/profile_ui.dart';
import '../../pharmacies/pharmacy_view.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'home_view_headr.dart';
import 'home_view_header_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;
  final bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  final List<Widget> items = [
    Icon(Icons.home, size: 30.sp),
    FaIcon(FontAwesomeIcons.hospital, size: 30.sp),
    Icon(FontAwesomeIcons.flask, size: 30.sp),
    Icon(Icons.local_shipping, size: 30.sp),
    Icon(Icons.person, size: 30.sp),
  ];

  final List<Widget> widgetOptions = <Widget>[
    const HomeViewBodyScreen(),
    BlocProvider(
      create: (context) =>
          PharmacyCubit(PharmacyRepoImpl(Dio()))..fetchPharmacies(),
      child: const PharmacyView(),
    ),
    BlocProvider(
      create: (context) => LaboratoryCubit(LaboratoryRepoImpl(Dio())),
      child: LaboratoryView(),
    ),
    DeliveryOptionsView(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          return false; // يرجعه للـ Home
        } else {
          bool shouldExit = await showDialog(
            context: context,
            builder: (context) => const CustomExitDialog(),
          );
          return shouldExit;
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          backgroundColor: colorScheme.background,
          color: colorScheme.surface,
          buttonBackgroundColor: colorScheme.primary,
          height: MediaQuery.of(context).size.height * 0.06,
          animationDuration: const Duration(milliseconds: 250),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          index: selectedIndex,
          items: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: selectedIndex == index
                      ? colorScheme.onError
                      : colorScheme.onSurface,
                ),
              ),
              child: item,
            );
          }).toList(),
        ),
        body: widgetOptions[selectedIndex],
      ),
    );
  }
}

class CustomExitDialog extends StatelessWidget {
  const CustomExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة تحذير
              Icon(
                Icons.warning_amber_rounded,
                size: 50.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 16.h),
              // العنوان
              Text(
                'تأكيد الخروج',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // المحتوى
              Text(
                'هل أنت متأكد أنك تريد الخروج من التطبيق؟',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر الإلغاء
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  // زر الخروج
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                              ),
                            ),
                    child: Text(
                      'خروج',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeViewBodyScreen extends StatelessWidget {
  const HomeViewBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeViewHeader(),
                HomeCarousel(),
                SizedBox(height: 24.h),
                const HomeViewHeaderCard(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
          TitleAndSeeAll(
            text: 'العروض',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfferGroupView()),
              );
            },
          ),
          SizedBox(height: 18.h),
          const OffersRow(),
          SizedBox(height: 24.h),
          const CustomWrapContainersHomeView(),
          TitleAndSeeAll(
            text: 'المقالات الطبية',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorBlogsView()),
              );
            },
          ),
          SizedBox(height: 24.h),
          const BlogsRow(),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}
