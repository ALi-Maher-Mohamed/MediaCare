import 'package:flutter/material.dart';
import 'widgets/search_view_body.dart';

import '../../../core/utlis/app_color.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryLight,
            title: Text('Recommendation '),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchViewBody(),
          )),
    );
  }
}
