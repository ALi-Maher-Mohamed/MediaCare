import 'package:flutter/material.dart';
import 'widgets/laboratory_view_body.dart';
import '../../../core/utils/app_color.dart';

class LaboratoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              "المعامل",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            backgroundColor: Colors.white),
        body: LaboratoryViewBody());
  }
}
