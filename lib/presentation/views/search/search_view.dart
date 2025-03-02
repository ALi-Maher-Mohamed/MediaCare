import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: null,
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.primary),
            backgroundColor: AppColors.lightGrey,
            title: Text(
              'أبحث عن دكتورك  ',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchViewBody(),
          )),
    );
  }
}
