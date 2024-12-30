import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'DocSpecialityModel.dart';

class CustomDocSpicalityGridView extends StatelessWidget {
  const CustomDocSpicalityGridView({
    super.key,
    required this.DocSpecialityData,
  });

  final List<DocSpeciality> DocSpecialityData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: DocSpecialityData.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
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
      },
    );
  }
}
