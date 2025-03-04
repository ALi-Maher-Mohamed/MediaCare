import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/pharmacies/data/service/api_service.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_details_page.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_view_body.dart';

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
