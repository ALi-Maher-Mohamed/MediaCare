import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo_impl.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_state.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/widgets/custom_shimmer_list_view.dart';
import 'package:shimmer/shimmer.dart';
import 'custom_laboratory_list_view.dart';

class LaboratoryViewBody extends StatelessWidget {
  const LaboratoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaboratoryCubit(LaboratoryRepoImpl(Dio())),
      child: BlocBuilder<LaboratoryCubit, LaboratoryState>(
        builder: (context, state) {
          if (state is LaboratoryLoadingState) {
            return CustomProgressIndicator();
          } else if (state is LaboratoryErrorState) {
            return Center(child: Text(state.errorMessage)); // عرض رسالة الخطأ
          } else if (state is LaboratorySuccessState) {
            print(state.laboratories); // للتأكد من البيانات (اختياري)
            return CustomLaboratoryListView(
              laboratories: state.laboratories,
              scrollController: context
                  .read<LaboratoryCubit>()
                  .scrollController, // تمرير ScrollController
            );
          }
          return Shimmer.fromColors(
            baseColor: AppColors.primary,
            highlightColor: Colors.white,
            child: const CustomShimmerListView(),
          );
        },
      ),
    );
  }
}
