import 'package:flutter/material.dart';

import 'DocSpecialityModel.dart';
import 'doc_speciality_item.dart';

class CustomDocSpicalityGridView extends StatelessWidget {
  const CustomDocSpicalityGridView({
    super.key,
    required this.DocSpecialityData,
  });

  final List<DocSpecialityModel> DocSpecialityData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: DocSpecialityData.length,
      itemBuilder: (context, index) {
        return DocSpecialityItem(
            DocSpecialityData: DocSpecialityData, index: index);
      },
    );
  }
}
