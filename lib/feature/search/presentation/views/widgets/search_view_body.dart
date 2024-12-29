import 'package:bookly_app/core/utlis/styles.dart';
import 'package:bookly_app/feature/search/presentation/views/widgets/custom_search_text_feild.dart';
import 'package:bookly_app/feature/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextFeild(),
          SizedBox(
            height: 16,
          ),
          Text(
            'Search Result ',
            style: Styles.textStyle18,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(child: SearchResultListVeiw())
        ],
      ),
    );
  }
}
