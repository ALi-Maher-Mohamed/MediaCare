import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/search/search_view.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // splashColor: AppColors.primary,
          // hoverColor: AppColors.primary,
          focusColor: AppColors.primaryLight,
          backgroundColor: AppColors.primary,
          shape: CircleBorder(),
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SearchView();
              },
            ));
          },
          elevation: 1,
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          height: 60,
          elevation: 1,
          notchMargin: 5.0,
          color: AppColors.primaryLight,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home),
              Icon(Icons.person_2),
            ],
          ),
        ),
        body: HomeViewBody(),
      ),
    );
  }
}
