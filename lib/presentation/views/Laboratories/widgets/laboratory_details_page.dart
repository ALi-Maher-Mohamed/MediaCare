import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class LaboratoryDetailsPage extends StatelessWidget {
  final LaboratoryModel laboratory;
  const LaboratoryDetailsPage({super.key, required this.laboratory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          laboratory.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  laboratory.image,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/Gifs/laboratory.gif',
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

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
                        "${laboratory.city}, ${laboratory.area}", context),
                    _infoRow(
                        "🛠️", "الخدمة المقدمة", laboratory.service, context),
                    _infoRow(
                        "⭐", "التقييم", "${laboratory.avgRate} / 5.0", context),
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
                _actionButton(context, Icons.phone, "اتصل بالمعمل",
                    () => launchDialer(laboratory.phone)),
                _actionButton(context, Icons.map, "عرض على الخريطة",
                    () => launchCustomUrl(context, laboratory.locationUrl)),
                _actionButton(context, FontAwesomeIcons.whatsapp, "واتساب",
                    () => launchCustomUrl(context, laboratory.whatsappLink)),
                _actionButton(context, Icons.star, "قيّم المعمل", () async {
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
                          create: (_) => LaboratoryRatingCubit(
                            LaboratoryRatingRepoImpl(
                                ApiServiceFunctions(Dio())),
                          ),
                        ),
                      ],
                      child: LaboratoryRatingBottomSheet(
                        laboratoryId: laboratory.id,
                        laboratoryName: laboratory.title,
                        laboratoryLocation:
                            '${laboratory.city}, ${laboratory.area}',
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
