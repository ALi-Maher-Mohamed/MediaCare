import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
import 'doc_speciality_item.dart';

class CustomDocSpecialityGridView extends StatelessWidget {
  const CustomDocSpecialityGridView({
    super.key,
    required this.docSpecialityData,
  });

  final List<DocSpecialityModel> docSpecialityData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: docSpecialityData.length,
      itemBuilder: (context, index) {
        return DocSpecialityItem(
            docSpecialityData: docSpecialityData, index: index);
      },
    );
  }
}
