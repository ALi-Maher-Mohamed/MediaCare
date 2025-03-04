import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';

class PharmacyListViewFooter extends StatelessWidget {
  const PharmacyListViewFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        if (state is! PharmacySuccessState) return SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (state.currentPage > 1)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(
                      side: BorderSide(color: AppColors.primary),
                    ),
                    backgroundColor: AppColors.lightGrey,
                  ),
                  onPressed: () => context
                      .read<PharmacyCubit>()
                      .fetchPharmacies(isPrevPage: true),
                  child: Text(
                    "السابق",
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              if (state.hasNextPage)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(
                      side: BorderSide(color: AppColors.primary),
                    ),
                    backgroundColor: AppColors.lightGrey,
                  ),
                  onPressed: () => context
                      .read<PharmacyCubit>()
                      .fetchPharmacies(isNextPage: true),
                  child: Text("التالي",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        );
      },
    );
  }
}
