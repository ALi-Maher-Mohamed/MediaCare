import 'package:flutter/material.dart';
import '../../Doctor Speciality/DocSpecialityModel.dart';
import '../../Doctor Speciality/doc_speciality_item.dart';

class SpecialityListView extends StatelessWidget {
  SpecialityListView({super.key});

  final List<DocSpecialityModel> spicialty = [
    DocSpecialityModel(
        name: 'ENT', image: 'assets/images/DoctorSpeciality/ENT.svg'),
    DocSpecialityModel(
        name: 'Dentistry',
        image: 'assets/images/DoctorSpeciality/Dentistry.svg'),
    DocSpecialityModel(
        name: 'Intestine',
        image: 'assets/images/DoctorSpeciality/intestine.svg'),
    DocSpecialityModel(
        name: 'Histologist',
        image: "assets/images/DoctorSpeciality/histologist.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
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
                      docSpecialityData: spicialty,
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
