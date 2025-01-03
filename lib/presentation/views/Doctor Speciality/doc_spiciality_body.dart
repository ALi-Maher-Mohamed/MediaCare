import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/custom_doc_grid_view.dart';

class DocSpicalityBody extends StatelessWidget {
  const DocSpicalityBody({
    super.key,
    required this.DocSpecialityData,
  });

  final List<DocSpecialityModel> DocSpecialityData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomDocSpicalityGridView(
        DocSpecialityData: DocSpecialityData,
      ),
    );
  }
}
