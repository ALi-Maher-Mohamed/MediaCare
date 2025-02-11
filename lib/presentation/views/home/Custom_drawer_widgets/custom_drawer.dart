import 'package:flutter/material.dart';
import '../../../../core/utlis/app_color.dart';
import 'menu_view_body.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryLight, body: MenuViewBody());
  }
}
