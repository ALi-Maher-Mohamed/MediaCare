import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'presentation/views/home/Custom_drawer_widgets/custom_drawer.dart';
import 'presentation/views/home/home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      drawerShadowsBackgroundColor: Theme.of(context).colorScheme.primary,
      menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      menuScreenOverlayColor: Theme.of(context).colorScheme.primary,
      style: DrawerStyle.defaultStyle,
      menuScreen: MenuView(), // تأكد إن MenuView بيستخدم الثيم
      mainScreen: const MainScreen(), // تأكد إن MainScreen بيستخدم الثيم
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
