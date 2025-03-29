import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title:
            Text('الصيدليات ', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoadingState) {
            return const CustomProgressIndicator();
          } else if (state is PharmacySuccessState) {
            return CustomPharmacyListView(
                pharmacies: state.pharmacies,
                scrollController: _scrollController);
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
