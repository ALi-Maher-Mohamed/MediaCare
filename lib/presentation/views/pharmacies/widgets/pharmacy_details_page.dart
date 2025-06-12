import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/repos/pharmacy_rating_repo_impl.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_cubit.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/widgets/rating_bottom_sheet.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/pharmacy_model.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final PharmacyModel pharmacy;
  final int index;
  const PharmacyDetailsPage(
      {super.key, required this.index, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          pharmacy.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الصيدلية
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: pharmacy.image == null
                    ? Image.asset(
                        'assets/Gifs/pharmacy.gif',
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        pharmacy.image!,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/Gifs/pharmacy.gif',
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 24.h),

            // معلومات الصيدلية
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow("📍", "الموقع",
                        "${pharmacy.city}, ${pharmacy.area}", context),
                    _infoRow(
                        "🛠️", "الخدمة المقدمة", pharmacy.service, context),
                    _infoRow(
                        "⭐", "التقييم", "${pharmacy.avgRate} / 5.0", context),
                    _infoRow(
                        "🚚",
                        "التوصيل",
                        pharmacy.deliveryOption == 1 ? "متاح" : "غير متاح",
                        context),
                    _infoRow(
                        "🛡️",
                        "التأمين الصحي",
                        pharmacy.insurence == 1 ? "مدعوم" : "غير مدعوم",
                        context),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // الأزرار التفاعلية
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _actionButton(context, Icons.phone, "اتصل بالصيدلية",
                    () => launchDialer(pharmacy.phone)),
                _actionButton(context, Icons.map, "عرض على الخريطة",
                    () => launchCustomUrl(context, pharmacy.locationUrl)),
                _actionButton(context, FontAwesomeIcons.whatsapp, "واتساب",
                    () => launchCustomUrl(context, pharmacy.whatsappLink)),
                _actionButton(context, Icons.star, "قيّم الصيدلية", () async {
                  final token = await SharedPreference().getToken();
                  final profileCubit = context.read<ProfileCubit>();

                  if (token == null || token.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
                        pharmacyId: pharmacy.id,
                        pharmacyName: pharmacy.title,
                        pharmacyLocation: '${pharmacy.city}, ${pharmacy.area}',
                      ),
                    ),
                  );
                }),
              ],
            )
          ],
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
