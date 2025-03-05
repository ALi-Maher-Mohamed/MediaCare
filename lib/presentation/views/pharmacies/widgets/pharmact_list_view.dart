import 'pharmacy_list_view_footer.dart';

import 'pharmacy_list_view_item.dart';
import '../../search/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import '../data/model/pharmacy_model.dart';

class CustomPharmacyListView extends StatelessWidget {
  const CustomPharmacyListView({
    super.key,
    required this.pharmacies,
  });
  final List<PharmacyModel> pharmacies;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(),
        Expanded(
          child: ListView.builder(
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = pharmacies[index];
              return PharmacyListViewItem(pharmacy: pharmacy, index: index);
            },
          ),
        ),
        PharmacyListViewFooter(),
      ],
    );
  }
}
