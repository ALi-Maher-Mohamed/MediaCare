import 'package:flutter/material.dart';
import 'widgets/laboratory_view_body.dart';

class LaboratoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              "المعامل",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface),
        body: LaboratoryViewBody());
  }
}
