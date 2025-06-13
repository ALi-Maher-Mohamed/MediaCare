import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/repos/pharmacy_rating_repo_impl.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_cubit.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_state.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/widgets/rating_bottom_sheet.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_cubit.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_state.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details_mode;.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import '../../../core/utils/functins/launch_url.dart';

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

    // Fetch pharmacy details
    context
        .read<PharmacyDetailsCubit>()
        .fetchPharmacyDetails(widget.pharmacyId);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _showRatingBottomSheet(BuildContext context) async {
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
          pharmacyId: widget.pharmacyId,
          pharmacyName: context.read<PharmacyDetailsCubit>().state
                  is PharmacyDetailsSuccess
              ? (context.read<PharmacyDetailsCubit>().state
                      as PharmacyDetailsSuccess)
                  .pharmacy
                  .title
              : '',
          pharmacyLocation: context.read<PharmacyDetailsCubit>().state
                  is PharmacyDetailsSuccess
              ? '${(context.read<PharmacyDetailsCubit>().state as PharmacyDetailsSuccess).pharmacy.city}, ${(context.read<PharmacyDetailsCubit>().state as PharmacyDetailsSuccess).pharmacy.area}'
              : '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : Colors.grey[50],
      body: BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
        builder: (context, state) {
          if (state is PharmacyDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PharmacyDetailsSuccess) {
            final pharmacy = state.pharmacy;
            return Stack(
              children: [
                // Background Pattern
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
                    // Hero Section
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
                                child: pharmacy.image == null
                                    ? Image.asset(
                                        'assets/Gifs/pharmacy.gif',
                                        width: double.infinity,
                                        height: 320.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        pharmacy.image!,
                                        width: double.infinity,
                                        height: 320.h,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/Gifs/pharmacy.gif',
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

                            // Pharmacy Name
                            Positioned(
                              bottom: 30.h,
                              left: 20.w,
                              right: 20.w,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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

                    // Content
                    SliverToBoxAdapter(
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              // Rating Section
                              _buildFloatingRatingCard(context, pharmacy),
                              SizedBox(height: 30.h),

                              // Services Grid
                              _buildServicesGrid(context, pharmacy),
                              SizedBox(height: 30.h),

                              // Reviews Section
                              _buildReviewsSection(context, pharmacy),
                              SizedBox(height: 30.h),

                              // Action Buttons
                              _buildModernActionButtons(context, pharmacy),
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
          return Container();
        },
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
              onTap: () => _showRatingBottomSheet(context),
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
              icon: Icons.verified,
              value: "موثوق",
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
              icon: Icons.access_time,
              value: "24/7",
              label: "الخدمة",
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
    VoidCallback? onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context, PharmacyData pharmacy) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "خدماتنا",
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
          childAspectRatio: .9,
          children: [
            _buildServiceCard(
              context,
              icon: Icons.medical_services,
              title: "الخدمة",
              subtitle: pharmacy.service,
              color: Colors.blue,
            ),
            _buildServiceCard(
              context,
              icon: Icons.local_shipping,
              title: "التوصيل",
              subtitle: pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح",
              color:
                  pharmacy.deliveryOption == 1 ? Colors.green : Colors.orange,
            ),
            _buildServiceCard(
              context,
              icon: Icons.security,
              title: "التأمين",
              subtitle: pharmacy.insurance == 1 ? "مدعوم" : "غير مدعوم",
              color: pharmacy.insurance == 1 ? Colors.teal : Colors.grey,
            ),
            _buildServiceCard(
              context,
              icon: Icons.schedule,
              title: "المواعيد",
              subtitle: "متاح دائماً",
              color: Colors.purple,
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
        pharmacy.users.isEmpty
            ? Container(
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
                child: Center(
                  child: Text(
                    "لا توجد مراجعات بعد",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isDarkMode
                          ? AppColors.textLight.withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                ),
              )
            : Container(
                height: 200.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: pharmacy.users.length,
                  itemBuilder: (context, index) {
                    final user = pharmacy.users[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.1),
                                      child: user.avatar == null
                                          ? Icon(
                                              Icons.person,
                                              color: isDarkMode
                                                  ? AppColors.textLight
                                                  : Colors.black87,
                                              size: 20.sp,
                                            )
                                          : ClipOval(
                                              child: Image.network(
                                                user.avatar!,
                                                width: 40.r,
                                                height: 40.r,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.person,
                                                    color: isDarkMode
                                                        ? AppColors.textLight
                                                        : Colors.black87,
                                                    size: 20.sp,
                                                  );
                                                },
                                              ),
                                            ),
                                    ),
                                    SizedBox(width: 8.w),
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
                                  ],
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      Icons.star_rounded,
                                      size: 16.sp,
                                      color: starIndex < user.pivot.ratingValue
                                          ? Colors.amber
                                          : Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              user.pivot.review,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.textLight.withOpacity(0.8)
                                    : Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              user.pivot.createdAt.split('T')[0],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.textLight.withOpacity(0.6)
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
          "تواصل معنا",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textLight : Colors.black87,
          ),
        ),
        SizedBox(height: 20.h),

        // Phone Button
        _buildGlassButton(
          context,
          icon: Icons.phone_rounded,
          label: "اتصل بالصيدلية",
          subtitle: "للاستفسارات الطارئة",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.green[700]!, Colors.green[900]!]
                : [Colors.green[400]!, Colors.green[600]!],
          ),
          onPressed: () => launchDialer(pharmacy.phone),
        ),

        SizedBox(height: 16.h),

        // WhatsApp Button
        _buildGlassButton(
          context,
          icon: FontAwesomeIcons.whatsapp,
          label: "واتساب",
          subtitle: "للتواصل السريع",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Color(0xFF128C7E), Color(0xFF0A5F55)]
                : [Color(0xFF25D366), Color(0xFF128C7E)],
          ),
          onPressed: () => launchCustomUrl(context, pharmacy.whatsappLink),
          isWhatsApp: true,
        ),

        SizedBox(height: 16.h),

        // Map Button
        _buildGlassButton(
          context,
          icon: Icons.map_rounded,
          label: "عرض على الخريطة",
          subtitle: "للوصول بسهولة",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.blue[700]!, Colors.blue[900]!]
                : [Colors.blue[400]!, Colors.blue[600]!],
          ),
          onPressed: () => launchCustomUrl(context, pharmacy.locationUrl),
        ),

        SizedBox(height: 16.h),

        // Rate Button
        _buildGlassButton(
          context,
          icon: Icons.star_rounded,
          label: "قيّم الصيدلية",
          subtitle: "شاركنا رأيك",
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.amber[700]!, Colors.orange[900]!]
                : [Colors.amber[600]!, Colors.orange[600]!],
          ),
          onPressed: () => _showRatingBottomSheet(context),
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
