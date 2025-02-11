import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Doctor Speciality/DocSpecialityModel.dart';

import 'custom_search_bar.dart';
import 'serch_view_recommend_item.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key});
  final DocSpecialityData = [
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
    DocSpecialityModel(
        name: 'Hepatology',
        image: 'assets/images/DoctorSpeciality/Hepatology.svg'),
    // DocSpecialityModel(
    //     name: 'General', image: 'assets/images/DoctorSpeciality/gen.svg'),
    DocSpecialityModel(
        name: 'Cardiologist',
        image: 'assets/images/DoctorSpeciality/cardiologist.svg'),
    DocSpecialityModel(
        name: 'Pulmonary',
        image: 'assets/images/DoctorSpeciality/pulmonary.svg'),
    DocSpecialityModel(
        name: 'Optometry',
        image: 'assets/images/DoctorSpeciality/Optometry.svg'),
    DocSpecialityModel(
        name: 'Pediatric',
        image: 'assets/images/DoctorSpeciality/Pediatric.svg'),
    DocSpecialityModel(
        name: 'Urologist',
        image: 'assets/images/DoctorSpeciality/Urologist.svg'),
    DocSpecialityModel(
        name: 'Neurologic',
        image: 'assets/images/DoctorSpeciality/Neurologic.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: CustomSearchBar(),
      ),
      SliverFillRemaining(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: DocSpecialityData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SearchViewRecommendItem(
                name: DocSpecialityData[index].name,
                image: DocSpecialityData[index].image,
              ),
            );
          },
        ),
      ),
    ]);
  }
}
