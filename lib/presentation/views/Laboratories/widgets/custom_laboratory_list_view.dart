import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/search/widgets/custom_search_bar.dart';
import '../data/model/labs_model/data.dart';
import 'custom_laboratory_list_view_item.dart';

class CustomLaboratoryListView extends StatelessWidget {
  final List<LaboratoryModel> laboratories;
  final ScrollController scrollController;

  const CustomLaboratoryListView({
    super.key,
    required this.laboratories,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'ابحث عن مختبر',
          onSearch: (query) {
            context.read<LaboratoryCubit>().searchLaboratories(query);
          },
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: laboratories.length + 1,
            itemBuilder: (context, index) {
              if (index == laboratories.length) {
                return context.read<LaboratoryCubit>().hasMore
                    ? const CustomProgressIndicator()
                    : const SizedBox.shrink();
              }
              final laboratory = laboratories[index];

              return LaboratoryListViewItem(
                laboratory: laboratory,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
