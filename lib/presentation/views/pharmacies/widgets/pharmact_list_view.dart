import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';

import 'pharmacy_list_view_item.dart';
import '../../search/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import '../data/model/pharmacy_model.dart';

class CustomPharmacyListView extends StatelessWidget {
  final List<PharmacyModel> pharmacies;
  final ScrollController scrollController;

  const CustomPharmacyListView({
    super.key,
    required this.pharmacies,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomSearchBar(),
      Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemCount: pharmacies.length + 1,
          itemBuilder: (context, index) {
            if (index == pharmacies.length) {
              return context.read<PharmacyCubit>().hasMore
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }
            return PharmacyListViewItem(
                pharmacy: pharmacies[index], index: index);
            // PharmacyItem(pharmacy: pharmacies[index]);
          },
        ),
      ),
    ]);
  }
}
