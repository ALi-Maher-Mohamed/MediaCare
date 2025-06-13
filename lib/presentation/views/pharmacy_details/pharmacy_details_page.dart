import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/repos/pharmacy_rating_repo_impl.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_cubit.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/widgets/rating_bottom_sheet.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_cubit.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_state.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details_mode;.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/repos/pharmacy_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';

class PharmacyDetailsPage extends StatefulWidget {
  final String pharmacyId;
  const PharmacyDetailsPage({super.key, required this.pharmacyId});

  @override
  State<PharmacyDetailsPage> createState() => _PharmacyDetailsPageState();
}

class _PharmacyDetailsPageState extends State<PharmacyDetailsPage>
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

  Future<void> _showRatingBottomSheet(BuildContext context, String pharmacyId,
      String pharmacyName, String pharmacyLocation) async {
    final token = await SharedPreference().getToken();
    final profileCubit = context.read<ProfileCubit>();

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يجب تسجيل الدخول أولاً'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: profileCubit),
          BlocProvider(
            create: (_) => PharmacyRatingCubit(
              PharmacyRatingRepoImpl(ApiServiceFunctions(Dio())),
            ),
          ),
        ],
        child: PharmacyRatingBottomSheet(
          pharmacyId: pharmacyId,
          pharmacyName: pharmacyName,
          pharmacyLocation: pharmacyLocation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiService = ApiServiceFunctions(dio);
    final repository = PharmacyDetailsRepoImpl(apiService: apiService);
    final cubit = PharmacyDetailsCubit(repository);

    cubit.fetchPharmacyDetails(widget.pharmacyId);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : Colors.grey[50],
      body: BlocProvider(
        create: (_) => cubit,
        child: BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
          builder: (context, state) {
            if (state is PharmacyDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PharmacyDetailsSuccess) {
              final pharmacy = state.pharmacy;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDarkMode
                            ? [
                                AppColors.backgroundDark,
                                AppColors.secondary.withOpacity(0.8),
                                Color(0xff1C252F),
                              ]
                            : [
                                Colors.blue[50]!,
                                Colors.cyan[50]!,
                                Colors.teal[50]!,
                              ],
                      ),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 320.h,
                        floating: false,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: isDarkMode
                            ? AppColors.backgroundDark
                            : Colors.transparent,
                        leading: Container(
                          margin: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.surfaceDark.withOpacity(0.9)
                                : Colors.white.withOpacity(0.9),
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
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: isDarkMode
                                  ? AppColors.textLight
                                  : Colors.black87,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
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
                                    pharmacy.image ??
                                        'assets/pharmacies/pharmacy.png',
                                    width: double.infinity,
                                    height: 320.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/pharmacies/pharmacy.png',
                                        width: double.infinity,
                                        height: 320.h,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40.r),
                                    bottomRight: Radius.circular(40.r),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: isDarkMode
                                        ? [
                                            Colors.transparent,
                                            AppColors.backgroundDark
                                                .withOpacity(0.8),
                                          ]
                                        : [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.8),
                                          ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30.h,
                                left: 20.w,
                                right: 20.w,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8.w),
                                            decoration: BoxDecoration(
                                              color: isDarkMode
                                                  ? AppColors.primary
                                                      .withOpacity(0.2)
                                                  : Colors.purple
                                                      .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Icon(
                                              Icons.local_pharmacy,
                                              color: AppColors.textLight,
                                              size: 20.sp,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            "صيدلية",
                                            style: TextStyle(
                                              color: AppColors.textLight
                                                  .withOpacity(0.8),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        pharmacy.title,
                                        style: TextStyle(
                                          color: AppColors.textLight,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
                                          color: isDarkMode
                                              ? AppColors.surfaceDark
                                                  .withOpacity(0.2)
                                              : Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          border: Border.all(
                                            color: AppColors.textLight
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: AppColors.textLight,
                                                size: 16.sp,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                "${pharmacy.city}, ${pharmacy.area}",
                                                style: TextStyle(
                                                  color: AppColors.textLight,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
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
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              children: [
                                _buildFloatingRatingCard(context, pharmacy),
                                SizedBox(height: 30.h),
                                _buildServicesGrid(context, pharmacy),
                                SizedBox(height: 30.h),
                                _buildModernActionButtons(context, pharmacy),
                                SizedBox(height: 30.h),
                                _buildReviewsSection(context, pharmacy),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is PharmacyDetailsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildFloatingRatingCard(BuildContext context, PharmacyData pharmacy) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      transform: Matrix4.translationValues(0, -30.h, 0),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.surfaceDark : Colors.white,
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
              value: "${pharmacy.avgRate}",
              label: "التقييم",
              color: Colors.amber,
            ),
            Container(
              height: 40.h,
              width: 1,
              color: isDarkMode
                  ? AppColors.textLight.withOpacity(0.2)
                  : Colors.grey[300],
            ),
            _buildRatingItem(
              context,
              icon: Icons.verified_user,
              value: pharmacy.insurance == 1 ? "معتمد" : "غير معتمد",
              label: "الجودة",
              color: Colors.green,
            ),
            Container(
              height: 40.h,
              width: 1,
              color: isDarkMode
                  ? AppColors.textLight.withOpacity(0.2)
                  : Colors.grey[300],
            ),
            _buildRatingItem(
              context,
              icon: Icons.local_shipping,
              value: pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح",
              label: "التوصيل",
              color: Colors.blue,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
            color: isDarkMode ? AppColors.textLight : Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDarkMode
                ? AppColors.textLight.withOpacity(0.7)
                : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context, PharmacyData pharmacy) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خدمات الصيدلية",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textLight : Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: .8,
          children: [
            _buildServiceCard(
              context,
              icon: Icons.medical_services,
              title: "الخدمة",
              subtitle: pharmacy.service,
              color: Colors.purple,
            ),
            _buildServiceCard(
              context,
              icon: Icons.local_shipping,
              title: "التوصيل",
              subtitle: pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح",
              color: Colors.blue,
            ),
            _buildServiceCard(
              context,
              icon: Icons.security,
              title: "التأمين",
              subtitle: pharmacy.insurance == 1 ? "مدعوم" : "غير مدعوم",
              color: Colors.teal,
            ),
            _buildServiceCard(
              context,
              icon: Icons.schedule,
              title: "المواعيد",
              subtitle: "من ${pharmacy.startAt} إلى ${pharmacy.endAt}",
              color: Colors.orange,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : Colors.white,
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
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.2),
                ],
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
              color: isDarkMode
                  ? AppColors.textLight.withOpacity(0.7)
                  : Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.textLight : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildReviewsSection(BuildContext context, PharmacyData pharmacy) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مراجعات الزوار",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textLight : Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        if (pharmacy.users.isNotEmpty)
          ...pharmacy.users
              .map(
                (user) => Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: user.avatar != null
                            ? NetworkImage(user.avatar!)
                            : null,
                        child: user.avatar == null
                            ? Icon(
                                Icons.person,
                                size: 24.sp,
                                color: isDarkMode
                                    ? AppColors.textLight
                                    : Colors.black87,
                              )
                            : null,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? AppColors.textLight
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              user.pivot.review.isNotEmpty
                                  ? user.pivot.review
                                  : "لا توجد مراجعة",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.textLight.withOpacity(0.7)
                                    : Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < user.pivot.ratingValue
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              user.pivot.createdAt.isNotEmpty
                                  ? _formatDate(user.pivot.createdAt)
                                  : "غير متاح",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.textLight.withOpacity(0.6)
                                    : Colors.grey[500],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        if (pharmacy.users.isEmpty)
          Text(
            "لا توجد مراجعات",
            style: TextStyle(
              fontSize: 16.sp,
              color: isDarkMode
                  ? AppColors.textLight.withOpacity(0.7)
                  : Colors.grey[600],
            ),
          ),
      ],
    );
  }

  Widget _buildModernActionButtons(
      BuildContext context, PharmacyData pharmacy) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تواصل مع الصيدلية",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textLight : Colors.black87,
          ),
        ),
        SizedBox(height: 20.h),
        _buildGlassButton(
          context,
          icon: Icons.star_rate_rounded,
          label: "تقييم الصيدلية",
          subtitle: "شاركنا رأيك عن الخدمة",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.amber[700]!, Colors.orange[900]!]
                : [Colors.amber[600]!, Colors.orange[600]!],
          ),
          onPressed: () => _showRatingBottomSheet(context, pharmacy.id,
              pharmacy.title, "${pharmacy.city}, ${pharmacy.area}"),
        ),
        SizedBox(height: 16.h),
        _buildGlassButton(
          context,
          icon: Icons.phone_rounded,
          label: "اتصل بالصيدلية",
          subtitle: "للاستفسارات والمواعيد",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.green[700]!, Colors.green[900]!]
                : [Colors.green[400]!, Colors.green[600]!],
          ),
          onPressed: () => launchDialer(pharmacy.phone),
        ),
        SizedBox(height: 16.h),
        _buildGlassButton(
          context,
          icon: FontAwesomeIcons.whatsapp,
          label: "واتساب",
          subtitle: "للتواصل والاستشارات",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Color(0xFF128C7E), Color(0xFF0A5F55)]
                : [Color(0xFF25D366), Color(0xFF128C7E)],
          ),
          onPressed: () => launchCustomUrl(context, pharmacy.whatsappLink),
          isWhatsApp: true,
        ),
        SizedBox(height: 16.h),
        _buildGlassButton(
          context,
          icon: Icons.map_rounded,
          label: "عرض على الخريطة",
          subtitle: "للوصول إلى الصيدلية",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.purple[700]!, Colors.purple[900]!]
                : [Colors.purple[400]!, Colors.purple[600]!],
          ),
          onPressed: () => launchCustomUrl(context, pharmacy.locationUrl),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                  color: isDarkMode
                      ? AppColors.surfaceDark.withOpacity(0.2)
                      : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: isWhatsApp
                      ? FaIcon(icon, color: AppColors.textLight, size: 28.sp)
                      : Icon(icon, color: AppColors.textLight, size: 28.sp),
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
                          color: AppColors.textLight,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: AppColors.textLight.withOpacity(0.8),
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
                  color: AppColors.textLight,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
