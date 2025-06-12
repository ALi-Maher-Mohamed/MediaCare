// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:media_care/presentation/views/Doctor%20Speciality/DocSpecialityModel.dart';
// import 'package:media_care/presentation/views/Doctor%20Speciality/doc_spiciality_body.dart';
// import '../../../core/utils/app_color.dart';

// class DoctorSpecialityView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final docSpecialityData = [
//       DocSpecialityModel(
//           name: 'ENT', image: 'assets/images/DoctorSpeciality/ENT.svg'),
//       DocSpecialityModel(
//           name: 'Dentistry',
//           image: 'assets/images/DoctorSpeciality/Dentistry.svg'),
//       DocSpecialityModel(
//           name: 'Intestine',
//           image: 'assets/images/DoctorSpeciality/intestine.svg'),
//       DocSpecialityModel(
//           name: 'Histologist',
//           image: "assets/images/DoctorSpeciality/histologist.svg"),
//       DocSpecialityModel(
//           name: 'Hepatology',
//           image: 'assets/images/DoctorSpeciality/Hepatology.svg'),
//       DocSpecialityModel(
//           name: 'General', image: 'assets/images/DoctorSpeciality/gen.svg'),
//       DocSpecialityModel(
//           name: 'Cardiologist',
//           image: 'assets/images/DoctorSpeciality/cardiologist.svg'),
//       DocSpecialityModel(
//           name: 'Pulmonary',
//           image: 'assets/images/DoctorSpeciality/pulmonary.svg'),
//       DocSpecialityModel(
//           name: 'Optometry',
//           image: 'assets/images/DoctorSpeciality/Optometry.svg'),
//       DocSpecialityModel(
//           name: 'Pediatric',
//           image: 'assets/images/DoctorSpeciality/Pediatric.svg'),
//       DocSpecialityModel(
//           name: 'Urologist',
//           image: 'assets/images/DoctorSpeciality/Urologist.svg'),
//       DocSpecialityModel(
//           name: 'Neurologic',
//           image: 'assets/images/DoctorSpeciality/Neurologic.svg'),
//     ];
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         forceMaterialTransparency: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Doctor Speciality',
//             style: GoogleFonts.inter(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textLight)),
//         centerTitle: true,
//       ),
//       body: DocSpecialityBody(docSpecialityData: docSpecialityData),
//     );
//   }
// }
