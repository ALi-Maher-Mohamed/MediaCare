import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/home/widgets/custom_home_feature_container.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'package:media_care/presentation/views/search/search_view.dart';
import 'package:redacted/redacted.dart';
import 'pharmacy_list_view.dart';
import 'search_doctor_field.dart';
import '../../pharmacies/pharmacy_view.dart';
import '../../Doctor%20Speciality/DocSpeciality.dart';
import '../../pharmacies/data/service/api_service.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'home_view_headr.dart';
import 'title_and_see_all.dart';

import 'home_view_header_card.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late List<PharmacyModel> pharmacies;
  int selectedIndex = 0;
  final bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget> widgetOptions = <Widget>[
    HomeViewBodyScreen(),
    SearchView(),
    BlocProvider(
      create: (context) => PharmacyCubit(apiService: PharmacyService())
        ..loadPharmacies(pageNumber: 1),
      child: PharmacyView(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 250),
          key: bottomNavigationKey,
          backgroundColor: Colors.white,
          color: AppColors.primaryLight,
          height: MediaQuery.of(context).size.height * 0.06,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          index: selectedIndex,
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: AppColors.darkGrey,
            ),
            Icon(
              Icons.search,
              size: 30,
              color: AppColors.darkGrey,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: AppColors.darkGrey,
            ),
          ]),
      body: widgetOptions[selectedIndex],
    );
  }
}

class HomeViewBodyScreen extends StatelessWidget {
  const HomeViewBodyScreen({
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
                  return DoctorSpecialityView();
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
