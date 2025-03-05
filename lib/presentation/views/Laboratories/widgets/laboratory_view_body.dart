import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/services/laps_service.dart';
import '../manager/cubit/labs_cubit.dart';
import '../manager/cubit/labs_state.dart';
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
          if (state is LaboratoryLoading &&
              (state is! LaboratorySuccessState)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LaboratoryError) {
            return Center(child: Text('error'));
          } else if (state is LaboratorySuccessState) {
            return CustomLaboratoryListView(
              laboratories: state.laboratories,
              currentPage: state.currentPage,
              hasNextPage: state.hasMore,
            );
          }
          return Container();
        },
      ),
    );
  }
}
