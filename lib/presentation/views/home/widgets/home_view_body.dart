import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/home/widgets/custom_home_feature_container.dart';
import 'pharmacy_list_view.dart';
import '../../../../core/utils/app_color.dart';
import 'search_doctor_field.dart';
import '../../pharmacies/pharmacy_view.dart';
import '../../Doctor%20Speciality/DocSpeciality.dart';
import '../../pharmacies/data/service/api_service.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'home_view_headr.dart';
import 'title_and_see_all.dart';

import 'home_view_header_card.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
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

        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          runSpacing: 10,
          spacing: 10,
          direction: Axis.horizontal,
          children: [
            CustomHomeFeatureContainer(
              image: 'assets/pharmacies/pharmacy_icon.png',
              text: 'الصيدلياتٍ',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        PharmacyCubit(apiService: PharmacyService())
                          ..loadPharmacies(pageNumber: 1),
                    child: PharmacyView(),
                    // PharmacyDetailsPage(
                    //   index: 0,
                    // ),
                  );
                }));
              },
            ),
            CustomHomeFeatureContainer(
              image: 'assets/pharmacies/labs.png',
              text: 'المعامل ',
            ),
            CustomHomeFeatureContainer(
              image: 'assets/pharmacies/doctors_icon.png',
              text: 'الاقسام الطبية ',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorSpecialityScreen();
                }));
              },
            ),
            CustomHomeFeatureContainer(
              image: 'assets/pharmacies/blogs.jfif',
              text: 'المقالات الطبية',
            ),
          ],
        ),
        // TitleAndSeeAll(
        //   onTap: () {},
        //   text: 'Top Offers',
        // ),
        // SizedBox(
        //   height: 12,
        // ),
        // // DoctorsOffers(),
        // TitleAndSeeAll(
        // onTap: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return DoctorSpecialityScreen();
        //   }));
        // },
        //   text: 'Specialty list',
        // ),
        // SpecialityListView(),
        SizedBox(
          height: 12,
        ),
        Column(
          children: [
            TitleAndSeeAll(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        PharmacyCubit(apiService: PharmacyService())
                          ..loadPharmacies(pageNumber: 1),
                    child: PharmacyView(),
                  );
                }));
              },
              text: 'Top Pharmacies',
            ),
            SizedBox(
              height: 12,
            ),
            BlocProvider(
              create: (context) {
                return PharmacyCubit(apiService: PharmacyService())
                  ..loadPharmacies(pageNumber: 1);
              },
              child: PharmacyListView(),
            ),
          ],
        ),
      ]),
    );
  }
}
