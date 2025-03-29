import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
import '../../../core/utils/app_color.dart';

class DocSpecialityItem extends StatelessWidget {
  const DocSpecialityItem({
    super.key,
    this.color,
    required this.docSpecialityData,
    required this.index,
  });
  final Color? color;
  final List<DocSpecialityModel> docSpecialityData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: color ?? AppColors.primaryLight,
          child: SvgPicture.asset(
            docSpecialityData[index].image,
            height: 50,
            width: 40,
          ),
        ),
        SizedBox(height: 18),
        Text(
          docSpecialityData[index].name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
