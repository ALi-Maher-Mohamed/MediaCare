import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/service/pharmacy_service.dart';
import '../manager/cubit/pharmacy_cubit.dart';
import 'pharmact_list_view.dart';

class PharmacyViewBody extends StatelessWidget {
  const PharmacyViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit(PharmacyService())..fetchPharmacies(),
      child: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoading && (state is! PharmacySuccessState)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PharmacyError) {
            return Center(child: Text(state.message));
          } else if (state is PharmacySuccessState) {
            return CustomPharmacyListView(
              pharmacies: state.pharmacies,
            );
          }
          return Container();
        },
      ),
    );
  }
}
