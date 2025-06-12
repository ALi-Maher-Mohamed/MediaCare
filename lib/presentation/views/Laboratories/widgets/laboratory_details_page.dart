import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/repo/laboratory_rating_repo_impl.dart';
import 'package:media_care/presentation/views/laboratories_rating/manager/cubit/laboratory_rating_cubit.dart';
import 'package:media_care/presentation/views/laboratories_rating/widgets/LaboratoryRatingBottomSheet%20.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/labs_model/data.dart';

class LaboratoryDetailsPage extends StatefulWidget {
  final LaboratoryModel laboratory;
  const LaboratoryDetailsPage({super.key, required this.laboratory});

  @override
  State<LaboratoryDetailsPage> createState() => _LaboratoryDetailsPageState();
}

class _LaboratoryDetailsPageState extends State<LaboratoryDetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Background Pattern
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[50]!,
                  Colors.cyan[50]!,
                  Colors.teal[50]!,
                ],
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              // Hero Section
              SliverAppBar(
                expandedHeight: 320.h,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Container(
                  margin: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Hero Image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(40.r),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(40.r),
                          ),
                          child: Image.network(
                            widget.laboratory.image,
                            width: double.infinity,
                            height: 320.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/pharmacies/labs.png',
                                width: double.infinity,
                                height: 320.h,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),

                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(40.r),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),

                      // Laboratory Name
                      Positioned(
                        bottom: 30.h,
                        left: 20.w,
                        right: 20.w,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.science,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "معمل تحاليل طبية",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                widget.laboratory.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "${widget.laboratory.city}, ${widget.laboratory.area}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        // Rating Section
                        _buildFloatingRatingCard(context),
                        SizedBox(height: 30.h),

                        // Services Grid
                        _buildServicesGrid(context),
                        SizedBox(height: 30.h),

                        // Action Buttons
                        _buildModernActionButtons(context),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingRatingCard(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -30.h, 0),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRatingItem(
              context,
              icon: Icons.star_rounded,
              value: "${widget.laboratory.avgRate}",
              label: "التقييم",
              color: Colors.amber,
            ),
            Container(
              height: 40.h,
              width: 1,
              color: Colors.grey[300],
            ),
            _buildRatingItem(
              context,
              icon: Icons.verified_user,
              value: "معتمد",
              label: "الجودة",
              color: Colors.green,
            ),
            Container(
              height: 40.h,
              width: 1,
              color: Colors.grey[300],
            ),
            _buildRatingItem(
              context,
              icon: Icons.biotech,
              value: "دقيق",
              label: "التحاليل",
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خدماتنا المعملية",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: .9,
          children: [
            _buildServiceCard(
              context,
              icon: Icons.science,
              title: "التحاليل",
              subtitle: widget.laboratory.service,
              color: Colors.purple,
            ),
            _buildServiceCard(
              context,
              icon: Icons.medical_information,
              title: "التقارير",
              subtitle: "تقارير مفصلة",
              color: Colors.blue,
            ),
            _buildServiceCard(
              context,
              icon: Icons.schedule,
              title: "المواعيد",
              subtitle: "حجز سريع",
              color: Colors.orange,
            ),
            _buildServiceCard(
              context,
              icon: Icons.local_hospital,
              title: "الخبرة",
              subtitle: "فريق متخصص",
              color: Colors.teal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تواصل مع المعمل",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 20.h),

        // Phone Button
        _buildGlassButton(
          context,
          icon: Icons.phone_rounded,
          label: "اتصل بالمعمل",
          subtitle: "للاستفسارات والمواعيد",
          gradient:
              LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]),
          onPressed: () => launchDialer(widget.laboratory.phone),
        ),

        SizedBox(height: 16.h),

        // WhatsApp Button
        _buildGlassButton(
          context,
          icon: FontAwesomeIcons.whatsapp,
          label: "واتساب",
          subtitle: "للتواصل والاستشارات",
          gradient:
              LinearGradient(colors: [Color(0xFF25D366), Color(0xFF128C7E)]),
          onPressed: () =>
              launchCustomUrl(context, widget.laboratory.whatsappLink),
          isWhatsApp: true,
        ),

        SizedBox(height: 16.h),

        // Map Button
        _buildGlassButton(
          context,
          icon: Icons.map_rounded,
          label: "عرض على الخريطة",
          subtitle: "للوصول إلى المعمل",
          gradient: LinearGradient(
              colors: [Colors.purple[400]!, Colors.purple[600]!]),
          onPressed: () =>
              launchCustomUrl(context, widget.laboratory.locationUrl),
        ),
      ],
    );
  }

  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onPressed,
    bool isWhatsApp = false,
  }) {
    return Container(
      width: double.infinity,
      height: 80.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: isWhatsApp
                      ? FaIcon(icon, color: Colors.white, size: 28.sp)
                      : Icon(icon, color: Colors.white, size: 28.sp),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      String icon, String title, String value, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 20.sp)),
          SizedBox(width: 8.w),
          Text("$title: ",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      label: Text(label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
