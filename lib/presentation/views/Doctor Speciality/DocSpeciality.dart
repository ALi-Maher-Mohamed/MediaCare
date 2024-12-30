import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/Doctor%20Speciality/doc_spiciality_body.dart';
import 'DocSpecialityModel.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocSpecialityData = [
      DocSpeciality(
          name: 'ENT', image: 'assets/images/DoctorSpeciality/ENT.svg'),
      DocSpeciality(
          name: 'Dentistry',
          image: 'assets/images/DoctorSpeciality/Dentistry.svg'),
      DocSpeciality(
          name: 'Intestine',
          image: 'assets/images/DoctorSpeciality/intestine.svg'),
      DocSpeciality(
          name: 'Histologist',
          image: "assets/images/DoctorSpeciality/histologist.svg"),
      DocSpeciality(
          name: 'Hepatology',
          image: 'assets/images/DoctorSpeciality/Hepatology.svg'),
      DocSpeciality(
          name: 'General', image: 'assets/images/DoctorSpeciality/gen.svg'),
      DocSpeciality(
          name: 'Cardiologist',
          image: 'assets/images/DoctorSpeciality/cardiologist.svg'),
      DocSpeciality(
          name: 'Pulmonary',
          image: 'assets/images/DoctorSpeciality/pulmonary.svg'),
      DocSpeciality(
          name: 'Optometry',
          image: 'assets/images/DoctorSpeciality/Optometry.svg'),
      DocSpeciality(
          name: 'Pediatric',
          image: 'assets/images/DoctorSpeciality/Pediatric.svg'),
      DocSpeciality(
          name: 'Urologist',
          image: 'assets/images/DoctorSpeciality/Urologist.svg'),
      DocSpeciality(
          name: 'Neurologic',
          image: 'assets/images/DoctorSpeciality/Neurologic.svg'),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
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
                color: AppColors.darkGrey)),
        centerTitle: true,
      ),
      body: DocSpicalityBody(DocSpecialityData: DocSpecialityData),
    );
  }
}
