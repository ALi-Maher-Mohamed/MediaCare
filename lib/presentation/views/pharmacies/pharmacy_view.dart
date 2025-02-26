import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import 'widgets/pharmacy_view_body.dart';

class PharmacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text('الصيدليات', style: TextStyle(color: AppColors.primary))),
      body: PharmacyViewBody(),
    );
  }
}
