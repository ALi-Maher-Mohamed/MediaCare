import 'package:flutter/material.dart';

import '../../Doctor Speciality/DocSpecialityModel.dart';
import '../../Doctor Speciality/doc_speciality_item.dart';

class SpecialityListView extends StatelessWidget {
  const SpecialityListView({
    super.key,
    required this.spicialty,
  });

  final List<DocSpecialityModel> spicialty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Container(
            height: 180,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  spicialty.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DocSpecialityItem(
                      DocSpecialityData: spicialty,
                      index: index,
                    ),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 12,
        ),
      ]),
    );
  }
}
