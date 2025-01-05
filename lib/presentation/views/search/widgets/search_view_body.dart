import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_care/presentation/views/home/widgets/custom_list_doc_item.dart';

import 'custom_search_bar.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: CustomSearchBar(),
      ),
      SliverFillRemaining(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: CustomDocListViewItem(),
            );
          },
        ),
      ),
    ]);
  }
}
