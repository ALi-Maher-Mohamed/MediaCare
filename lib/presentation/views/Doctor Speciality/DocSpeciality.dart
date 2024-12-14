import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'DocSpecialityModel.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocSpecialityData = [
      DocSpeciality(
          name: 'General', image: 'assets/images/DoctorSpeciality/General.svg'),
      DocSpeciality(
          name: 'ENT', image: 'assets/images/DoctorSpeciality/ENT.svg'),
      DocSpeciality(
          name: 'Pediatric',
          image: 'assets/images/DoctorSpeciality/Pediatric.svg'),
      DocSpeciality(
          name: 'Urologist',
          image: 'assets/images/DoctorSpeciality/Urologist.svg'),
      DocSpeciality(
          name: 'Dentistry',
          image: 'assets/images/DoctorSpeciality/Dentistry.svg'),
      DocSpeciality(
          name: 'Intestine', image: 'assets/images/DoctorSpeciality/intestine.svg'),
      DocSpeciality(
          name: 'Histologist', image: "assets/images/DoctorSpeciality/histologist.svg"),
      DocSpeciality(
          name: 'Hepatology', image: 'assets/images/DoctorSpeciality/Hepatology.svg'),
      DocSpeciality(
          name: 'Cardiologist', image: 'assets/images/DoctorSpeciality/cardiologist.svg'),
      DocSpeciality(
          name: 'Neurologic', image: 'assets/images/DoctorSpeciality/Neurologic.svg'),
      DocSpeciality(
          name: 'Pulmonary', image: 'assets/images/DoctorSpeciality/pulmonary.svg'),
      DocSpeciality(
          name: 'Optometry', image: 'assets/images/DoctorSpeciality/Optometry.svg'),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Doctor Speciality',
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkGrey
        )
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 100.0,
          ),
          itemCount: DocSpecialityData.length,
          itemBuilder: (context, index) {
            // final specialty = specialties[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              CircleAvatar(

              radius: 50,
              backgroundColor: Colors.grey[200],
              child: SvgPicture.asset(DocSpecialityData[index].image,
              height: 39,
              width: 39,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 8),
            Text(
            DocSpecialityData[index].name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            ),
            ]
            ,
            );
          },
        ),
      ),
    );
  }
}
