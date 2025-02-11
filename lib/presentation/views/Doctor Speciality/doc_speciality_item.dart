import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utlis/app_color.dart';
import '../Doctor%20Speciality/DocSpecialityModel.dart';

class DocSpecialityItem extends StatelessWidget {
  const DocSpecialityItem({
    super.key,
    this.color,
    required this.DocSpecialityData,
    required this.index,
  });
  final Color? color;
  final List<DocSpecialityModel> DocSpecialityData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor:
              color == null ? AppColors.primaryLight : Colors.grey[200],
          child: SvgPicture.asset(
            DocSpecialityData[index].image,
            height: 50,
            width: 40,
          ),
        ),
        SizedBox(height: 18),
        Text(
          DocSpecialityData[index].name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
