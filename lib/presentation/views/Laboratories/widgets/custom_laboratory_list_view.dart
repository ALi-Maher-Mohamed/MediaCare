import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../data/model/labs_model/data.dart';
import '../manager/cubit/labs_cubit.dart';
import 'custom_laboratory_list_view_item.dart';
import '../../search/widgets/custom_search_bar.dart';

class CustomLaboratoryListView extends StatelessWidget {
  const CustomLaboratoryListView({
    super.key,
    required this.laboratories,
    required this.currentPage,
    required this.hasNextPage,
  });
  final List<LaboratoryModel> laboratories;
  final int currentPage;
  final bool hasNextPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(),
        Expanded(
          child: ListView.builder(
            itemCount: laboratories.length,
            itemBuilder: (context, index) {
              final laboratory = laboratories[index];
              return LaboratoryListViewItem(
                  laboratory: laboratory, index: index);
            },
          ),
        ),
        LaboratoryListViewFooter(
            currentPage: currentPage, hasNextPage: hasNextPage),
      ],
    );
  }
}

class LaboratoryListViewFooter extends StatelessWidget {
  const LaboratoryListViewFooter({
    super.key,
    required this.currentPage,
    required this.hasNextPage,
  });

  final int currentPage;
  final bool hasNextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (currentPage > 1)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(
                  side: BorderSide(color: AppColors.primary),
                ),
                backgroundColor: AppColors.lightGrey,
              ),
              onPressed: () => context
                  .read<LaboratoryCubit>()
                  .fetchLaboratories(isPrevPage: true),
              child: Text(
                "السابق",
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          if (hasNextPage)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(
                  side: BorderSide(color: AppColors.primary),
                ),
                backgroundColor: AppColors.lightGrey,
              ),
              onPressed: () => context
                  .read<LaboratoryCubit>()
                  .fetchLaboratories(isNextPage: true),
              child: Text(
                "التالي",
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
