import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchViewRecommendItem extends StatelessWidget {
  const SearchViewRecommendItem(
      {super.key, required this.name, required this.image});
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(width: 18),
          SvgPicture.asset(image),
          SizedBox(width: 14),
        ],
      ),
    );
  }
}
