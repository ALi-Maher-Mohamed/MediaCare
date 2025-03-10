import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Laboratories/data/services/laps_service.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_state.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/widgets/custom_shimmer_list_view.dart';
import 'package:shimmer/shimmer.dart';
import 'custom_laboratory_list_view.dart';

class LaboratoryViewBody extends StatelessWidget {
  const LaboratoryViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LaboratoryCubit(LaboratoryService())..fetchLaboratories(),
      child: BlocBuilder<LaboratoryCubit, LaboratoryState>(
        builder: (context, state) {
          if (state is LaboratoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LaboratoryError) {
            return Center(child: Text('error'));
          } else if (state is LaboratorySuccessState) {
            print(state.laboratories);
            return CustomLaboratoryListView(
              laboratories: state.laboratories,
              currentPage: state.currentPage,
              hasNextPage: state.hasMore,
            );
          }
          return Shimmer.fromColors(
            baseColor: AppColors.primary,
            highlightColor: Colors.white,
            child: CustomShimmerListView(),
          );
        },
      ),
    );
  }
}
