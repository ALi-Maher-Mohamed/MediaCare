import 'package:flutter/material.dart';

class CustomListViewItem extends StatelessWidget {
  CustomListViewItem({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            cacheWidth: 500,
            cacheHeight: 500,
            height: 100,
            image,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
