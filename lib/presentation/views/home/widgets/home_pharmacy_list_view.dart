import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';

class PharmacyListView extends StatelessWidget {
  PharmacyListView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.h,
      child:
          BlocBuilder<PharmacyCubit, PharmacyState>(builder: (context, State) {
        if (State is PharmacyLoadingState) {
          return CustomProgressIndicator();
        } else if (State is PharmacySuccessState) {
          final pharmacy = State.pharmacies;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pharmacy.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              );
            },
          );
        } else {
          return Center(
              child: Text(
            ' لا توجد بيانات متاحة للعرض',
            style: TextStyle(color: AppColors.primary, fontSize: 18.sp),
          ));
        }
      }),
    );
  }
}
