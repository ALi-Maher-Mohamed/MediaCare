import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_list_view.dart';

import '../manager/cubit/pharmacy_cubit.dart';

class pharmacyViewBody extends StatelessWidget {
  const pharmacyViewBody({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('الصيدليات ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primary)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
      ),
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoadingState) {
            return const CustomProgressIndicator();
          } else if (state is PharmacySuccessState) {
            return CustomPharmacyListView(
                pharmacies: state.pharmacies,
                scrollController: _scrollController);
            // CustomPharmacyListView(pharmacies: state.pharmacies);
          } else if (state is PharmacyErrorState) {
            return ErrorText(message: state.message);
          }
          return const CustomProgressIndicator();
        },
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String message;

  const ErrorText({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
