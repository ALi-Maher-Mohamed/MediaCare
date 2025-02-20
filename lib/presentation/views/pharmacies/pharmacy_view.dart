import 'package:flutter/material.dart';
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
