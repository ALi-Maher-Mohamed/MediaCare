import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Laboratories/Labs_view.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo_impl.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/home/widgets/wrap_container_home.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import 'package:media_care/presentation/views/profile/profile_ui.dart';
import 'package:media_care/presentation/views/search/search_view.dart';

import 'search_doctor_field.dart';
import '../../pharmacies/pharmacy_view.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'home_view_headr.dart';
import 'home_view_header_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;
  final bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  final List<Widget> items = [
    const Icon(Icons.home, size: 30),
    const FaIcon(FontAwesomeIcons.hospital, size: 30),
    const Icon(FontAwesomeIcons.flask, size: 30),
    const Icon(Icons.person, size: 30),
  ];

  final List<Widget> widgetOptions = <Widget>[
    const HomeViewBodyScreen(),
    BlocProvider(
      create: (context) =>
          PharmacyCubit(PharmacyRepoImpl(Dio()))..fetchPharmacies(),
      child: const PharmacyView(),
    ),
    BlocProvider(
      create: (context) => LaboratoryCubit(LaboratoryRepoImpl(Dio())),
      child: LaboratoryView(),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        backgroundColor: colorScheme.background,
        color: colorScheme.surface,
        buttonBackgroundColor: colorScheme.primary,
        height: MediaQuery.of(context).size.height * 0.06,
        animationDuration: const Duration(milliseconds: 250),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        index: selectedIndex,
        items: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: selectedIndex == index
                    ? colorScheme.onError
                    : colorScheme.onSurface,
              ),
            ),
            child: item,
          );
        }).toList(),
      ),
      body: widgetOptions[selectedIndex],
    );
  }
}

class HomeViewBodyScreen extends StatelessWidget {
  const HomeViewBodyScreen({super.key});

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
                const HomeViewHeader(),
                const HomeViewHeaderCard(),
                SizedBox(height: 24.h),
                const SearchDoctor(),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          const CustomWrapContainersHomeView(),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}
