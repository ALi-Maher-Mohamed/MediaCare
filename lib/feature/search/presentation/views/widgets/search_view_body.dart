import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_search_text_feild.dart';
import 'search_result_list_view.dart';

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
