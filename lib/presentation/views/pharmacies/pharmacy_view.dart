import 'package:flutter/material.dart';
import 'widgets/pharmacy_view_body.dart';
import '../../../core/utils/app_color.dart';

class PharmacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              " الصيدليات",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            backgroundColor: Colors.white),
        body: PharmacyViewBody());
  }
}
