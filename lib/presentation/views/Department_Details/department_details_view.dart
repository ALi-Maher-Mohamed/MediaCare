import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Department_Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department_Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department_Details/manager/department_details_cubit.dart';
import 'package:media_care/presentation/views/Department_Details/manager/department_details_state.dart';
import 'package:media_care/presentation/views/Department_Details/widgets/care_center_card.dart';
import 'package:media_care/presentation/views/Department_Details/widgets/doctor_card.dart';
import 'package:media_care/presentation/views/Department_Details/widgets/hospital_card.dart';
import 'package:media_care/presentation/views/Department_Details/widgets/tip_card.dart';

class DepartmentDetailsScreen extends StatelessWidget {
  final String departmentID;
  final String title;

  const DepartmentDetailsScreen(
      {Key? key, required this.departmentID, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get theme data for consistent theming
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => DepartmentDetailsCubit(
        departmentDetailsRepoImpl: DepartmentDetailsRepoImpl(
          ApiServiceFunctions(Dio()),
        ),
      )..getDepartmentDetails(departmentID),
      child: BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
        builder: (context, state) {
          if (state is DepartmentDetailsLoading) {
            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              body: CustomProgressIndicator(),
            );
          } else if (state is DepartmentDetailsLoaded) {
            String selectedCategory = state.selectedCategory;
            List<Tip> tips = state.departmentDetails.data.tips;
            final cubit = context.read<DepartmentDetailsCubit>();
            List<Hospital> hospitals = cubit.hospitals;
            List<CareCenter> careCenters = cubit.careCenters;
            List<Doctor> doctors = cubit.doctors;

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: theme.iconTheme.color ??
                      (isDark ? Colors.white : Colors.black87),
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: theme.textTheme.titleLarge?.color ??
                        (isDark ? Colors.white : Colors.black87),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tips Section
                    if (tips.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          children: [
                            Container(
                              width: 4.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'نصائح طبية',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: theme.textTheme.titleLarge?.color ??
                                    (isDark ? Colors.white : Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 100.h,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: false,
                          viewportFraction: 0.85,
                          padEnds: false,
                        ),
                        items: tips.map((tip) => TipCard(tip: tip)).toList(),
                      ),
                      SizedBox(height: 40.h),

                      // Clean Divider with theme support
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        height: 1.h,
                        color: theme.dividerColor.withOpacity(0.5),
                      ),
                      SizedBox(height: 40.h),
                    ] else
                      SizedBox(height: 32.h),

                    // Categories Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Container(
                            width: 4.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'الخدمات المتاحة',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.titleLarge?.color ??
                                  (isDark ? Colors.white : Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          if (hospitals.isNotEmpty)
                            _buildMinimalCategoryButton(
                              context,
                              "المستشفيات",
                              Icons.local_hospital_outlined,
                              selectedCategory == "المستشفيات",
                              () => context
                                  .read<DepartmentDetailsCubit>()
                                  .filterDepartmentData("المستشفيات"),
                            ),
                          if (careCenters.isNotEmpty)
                            _buildMinimalCategoryButton(
                              context,
                              "المراكز",
                              Icons.apartment_outlined,
                              selectedCategory == "المراكز",
                              () => context
                                  .read<DepartmentDetailsCubit>()
                                  .filterDepartmentData("المراكز"),
                            ),
                          if (doctors.isNotEmpty)
                            _buildMinimalCategoryButton(
                              context,
                              "الأطباء",
                              Icons.person_outline,
                              selectedCategory == "الأطباء",
                              () => context
                                  .read<DepartmentDetailsCubit>()
                                  .filterDepartmentData("الأطباء"),
                            ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 400.ms),

                    SizedBox(height: 32.h),

                    // Data List
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children:
                            state.filteredData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          Widget card;

                          if (item.runtimeType == Hospital) {
                            card = HospitalCard(hospital: item as Hospital);
                          } else if (item.runtimeType == CareCenter) {
                            card =
                                CareCenterCard(careCenter: item as CareCenter);
                          } else if (item.runtimeType == Doctor) {
                            card = DoctorCard(doctor: item as Doctor);
                          } else {
                            card = Container();
                          }

                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: card,
                          )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: (80 * index).ms)
                              .slideY(begin: 0.1);
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            );
          } else if (state is DepartmentDetailsError) {
            return _buildErrorState(context, state.message);
          }
          return _buildUnknownState(context);
        },
      ),
    );
  }

  Widget _buildMinimalCategoryButton(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Smart color selection based on theme
    final selectedBgColor = theme.primaryColor;
    final unselectedBgColor = isDark ? theme.cardColor : Colors.grey[50]!;

    final selectedBorderColor = theme.primaryColor;
    final unselectedBorderColor =
        isDark ? theme.dividerColor.withOpacity(0.3) : Colors.grey[300]!;

    final selectedTextColor = theme.primaryColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
    final unselectedTextColor = theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.grey[300] : Colors.grey[700]);

    final selectedIconColor = selectedTextColor;
    final unselectedIconColor = theme.iconTheme.color?.withOpacity(0.7) ??
        (isDark ? Colors.grey[400] : Colors.grey[600]);

    return Container(
      margin: EdgeInsets.only(right: 12.w),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? selectedBgColor : unselectedBgColor,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: isSelected ? selectedBorderColor : unselectedBorderColor,
              width: 1.5,
            ),
            // Add subtle shadow for depth
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  key: ValueKey(isSelected),
                  color: isSelected ? selectedIconColor : unselectedIconColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 8.w),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                  color: isSelected ? selectedTextColor : unselectedTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color:
              theme.iconTheme.color ?? (isDark ? Colors.white : Colors.black87),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color ??
                (isDark ? Colors.white : Colors.black87),
            fontSize: 22.sp,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: isDark ? Colors.red[300] : Colors.red[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'حدث خطأ',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.titleMedium?.color,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnknownState(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Text(
          'حالة غير معروفة',
          style: TextStyle(
            fontSize: 16.sp,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
