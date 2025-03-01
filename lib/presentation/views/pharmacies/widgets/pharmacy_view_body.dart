import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pharmact_list_view.dart';

import '../manager/cubit/pharmacy_cubit.dart';

class PharmacyViewBody extends StatelessWidget {
  const PharmacyViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        if (state is PharmacyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PharmacySuccessState) {
          // var pharmacy = [...state.pharmacies];

          return PharmacyCardsListView(
            pharmacies: [...state.pharmacies],
          );
        } else if (state is PharmacyError) {
          return Center(child: Text('حدث خطأ: ${state.message}'));
        }
        return Center(child: Text(' لا توجد بيانات متاحة للعرض'));
      },
    );
  }
}
