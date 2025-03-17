import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/widgets/clip_path.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/labs_model/data.dart';
import 'laboratory_details_page.dart';

class LaboratoryListViewItem extends StatelessWidget {
  const LaboratoryListViewItem({
    super.key,
    required this.laboratory,
    required this.index,
  });
  final int index;
  final LaboratoryModel laboratory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LaboratoryDetailsPage(laboratory: laboratory),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(children: [
            ClipPath(
              clipper: ContainerClipper(),
              child: Container(
                height: 200.h,
                width: double.infinity,
                color: AppColors.primary2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20.h),
                Text(
                  laboratory.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: Image.network(
                      laboratory.image,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/pharmacies/pharmacy_icon.png',
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      ),
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Center(child: CircularProgressIndicator()),
                      width: 90.w,
                      height: 90.h,
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(100.w, 35.h),
                        backgroundColor: AppColors.primary2,
                      ),
                      child: Icon(Icons.location_on,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        launchCustomUrl(context, '${laboratory.locationUrl}');
                      },
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(100.w, 35.h),
                          backgroundColor: AppColors.primary2,
                        ),
                        child: Text('المزيد',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            )),
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LaboratoryDetailsPage(
                                    laboratory: laboratory),
                              ),
                            )),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 20.w,
              bottom: 40.h,
              child: Text(' ${laboratory.city} - ${laboratory.area}',
                  style: TextStyle(color: AppColors.darkGrey, fontSize: 14.sp)),
            ),
          ]),
        ));
  }
}
// Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 laboratory.image,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     laboratory.title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${laboratory.city} - ${laboratory.area}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     laboratory.service,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.phone, color: AppColors.primary, size: 30),
//               onPressed: () {
//                 launchDialer(laboratory.phone);
//               },
//             ),
//           ],
//         ),
//       ),
