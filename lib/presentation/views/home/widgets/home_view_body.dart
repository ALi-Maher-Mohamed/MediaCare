import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpeciality.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
import 'package:media_care/presentation/views/home/widgets/home_view_headr.dart';

import 'doctor_list_view.dart';
import 'speciality_list_view.dart';
import 'title_and_see_all.dart';

import 'home_view_header_card.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
  });
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeViewHeader(),
                HomeViewHeaderCard(),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          TitleAndSeeAll(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorSpecialityScreen();
              }));
            },
            text: 'Specialty list',
          ),
          SpecialityListView(spicialty: spicialty),
          SizedBox(
            height: 12,
          ),
          TitleAndSeeAll(
            onTap: () {},
            text: 'Doctor list',
          ),
          SizedBox(
            height: 12,
          ),
          DoctorListView()
        ],
      ),
    );
  }
}
