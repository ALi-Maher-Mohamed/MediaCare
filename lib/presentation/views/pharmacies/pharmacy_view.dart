import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/model/pharmacy_model.dart';
import 'manager/cubit/pharmacy_cubit.dart';
import 'widgets/pharmacy_view_body.dart';

class PharmacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الصيدليات')),
      body: PharmacyViewBody(),
    );
  }
}
