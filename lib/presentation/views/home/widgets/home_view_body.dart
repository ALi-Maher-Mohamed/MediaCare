import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Laboratories/Labs_view.dart';
import 'package:media_care/presentation/views/Laboratories/data/services/laps_service.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/home/widgets/home_pharmacy_list_view.dart';
import 'package:media_care/presentation/views/home/widgets/wrap_container_home.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import 'package:media_care/presentation/views/profile/profile_ui.dart';
import 'package:media_care/presentation/views/search/search_view.dart';

import 'search_doctor_field.dart';
import '../../pharmacies/pharmacy_view.dart';
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
  int selectedIndex = 0;
  final bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget> items = [
    Icon(
      Icons.home,
      size: 30,
      color: AppColors.darkGrey,
    ),
    FaIcon(
      FontAwesomeIcons.hospital,
      color: AppColors.darkGrey,
      size: 30,
    ),
    Icon(
      FontAwesomeIcons.flask,
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
  ];
  List<Widget> widgetOptions = <Widget>[
    HomeViewBodyScreen(),
    BlocProvider(
      create: (context) =>
          PharmacyCubit(PharmacyRepoImpl(Dio()))..fetchPharmacies(),
      child: PharmacyView(),
    ),
    BlocProvider(
      create: (context) => LaboratoryCubit(LaboratoryService()),
      child: LaboratoryView(),
    ),
    SearchView(),
    ProfileScreen(),
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
          items: items),
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
                height: 24.h,
              ),
              SearchDoctor()
            ],
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        CustomWrapContainersHomeView(),
        SizedBox(
          height: 18.h,
        ),
        Column(
          children: [
            TitleAndSeeAll(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) => PharmacyCubit(PharmacyRepoImpl(Dio()))
                      ..fetchPharmacies(),
                    child: PharmacyView(),
                  );
                }));
              },
              text: 'Top Pharmacies',
            ),
            SizedBox(
              height: 12.h,
            ),
            BlocProvider(
              create: (context) {
                return PharmacyCubit(PharmacyRepoImpl(Dio()))
                  ..fetchPharmacies();
              },
              child: PharmacyListView(),
            ),
          ],
        ),
      ]),
    );
  }
}
