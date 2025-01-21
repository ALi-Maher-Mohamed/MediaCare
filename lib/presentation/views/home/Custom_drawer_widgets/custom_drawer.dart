import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/home/Custom_drawer_widgets/menu_view_body.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryLight, body: MenuViewBody());
  }
}
