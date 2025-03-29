import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/custom_doc_grid_view.dart';

class DocSpecialityBody extends StatelessWidget {
  const DocSpecialityBody({
    super.key,
    required this.docSpecialityData,
  });

  final List<DocSpecialityModel> docSpecialityData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomDocSpecialityGridView(docSpecialityData: docSpecialityData),
    );
  }
}
