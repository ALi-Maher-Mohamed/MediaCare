import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_cubit.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_state.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';

class PharmacyRatingBottomSheet extends StatelessWidget {
  final String pharmacyId;
  final String pharmacyName;
  final String pharmacyLocation;

  const PharmacyRatingBottomSheet({
    super.key,
    required this.pharmacyId,
    required this.pharmacyName,
    required this.pharmacyLocation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratingCubit = context.read<PharmacyRatingCubit>();
    final profileCubit = context.read<ProfileCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PharmacyRatingCubit, PharmacyRatingState>(
        listener: (context, state) {
          if (state is PharmacyRatingSuccess) {
            Navigator.pop(context, true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إرسال تقييمك بنجاح',
                    style: TextStyle(color: Colors.white)),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          final alreadyRated = state is PharmacyRatingError;
          final currentRating = state is PharmacyRatingUpdated
              ? state.rating
              : ratingCubit.rating;

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(pharmacyName, style: theme.textTheme.titleLarge),
                SizedBox(height: 8.h),
                Text("الموقع: $pharmacyLocation",
                    style: theme.textTheme.bodyMedium),
                SizedBox(height: 8.h),
                if (alreadyRated)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "لقد قمت بتقييم هذه الصيدلية من قبل",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!alreadyRated) ...[
                  Text('قيم هذه الصيدلية', style: theme.textTheme.titleMedium),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < currentRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 35,
                        ),
                        onPressed: () {
                          ratingCubit.updateRating(index + 1);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 55.h,
                    child: TextField(
                      onChanged: (value) => ratingCubit.updateReview(value),
                      decoration: InputDecoration(
                        labelText: 'اكتب تقييمك هنا',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: theme.colorScheme.primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: theme.colorScheme.primary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ratingCubit.isSubmitting
                        ? null
                        : () {
                            if (alreadyRated) {
                              Navigator.pop(context);
                            } else {
                              final userId = profileCubit.userId;
                              if (userId == null || userId.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('يجب تسجيل الدخول أولاً'),
                                  ),
                                );
                                return;
                              }
                              ratingCubit.submitRating(
                                userId: userId,
                                pharmacyId: pharmacyId,
                              );
                            }
                          },
                    child: ratingCubit.isSubmitting
                        ? const CircularProgressIndicator()
                        : Text(alreadyRated ? 'حسناً' : 'إرسال التقييم'),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
