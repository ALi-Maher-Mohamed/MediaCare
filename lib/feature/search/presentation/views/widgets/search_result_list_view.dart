import 'package:flutter/material.dart';

class SearchResultListVeiw extends StatelessWidget {
  const SearchResultListVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('data') //BooksListViewItem(),
            );
      },
    );
  }
}
