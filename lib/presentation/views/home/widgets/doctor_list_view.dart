import 'package:flutter/material.dart';

import 'custom_list_doc_item.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: CustomDocListViewItem(),
          );
        },
      ),
    );
  }
}
