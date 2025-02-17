import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/home/widgets/search_doctor_field.dart';
import '../../Doctor%20Speciality/DocSpeciality.dart';
import 'doctor_offers.dart';
import 'home_view_headr.dart';
import 'pharmacy_list_view.dart';

import 'speciality_list_view.dart';
import 'title_and_see_all.dart';

import 'home_view_header_card.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
  });

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
                SearchDoctor()
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TitleAndSeeAll(
            onTap: () {},
            text: 'Top Offers',
          ),
          SizedBox(
            height: 12,
          ),
          DoctorsOffers(),
          TitleAndSeeAll(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorSpecialityScreen();
              }));
            },
            text: 'Specialty list',
          ),
          SpecialityListView(),
          SizedBox(
            height: 12,
          ),
          TitleAndSeeAll(
            onTap: () {},
            text: 'Top Pharmacies',
          ),
          SizedBox(
            height: 12,
          ),
          PharmacyListView()
        ],
      ),
    );
  }
}
