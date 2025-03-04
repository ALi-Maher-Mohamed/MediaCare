import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_details_page.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_list_view_footer.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_list_view_item.dart';
import 'package:media_care/presentation/views/search/widgets/custom_search_bar.dart';

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
