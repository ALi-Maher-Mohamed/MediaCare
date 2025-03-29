import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/widgets/clip_path.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
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
            color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20.h),
                Text(
                  laboratory.title,
                  style: Theme.of(context).textTheme.titleLarge,
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
                              : CustomProgressIndicator(),
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(Icons.location_on,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 30),
                      onPressed: () {
                        launchCustomUrl(context, '${laboratory.locationUrl}');
                      },
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(100.w, 35.h),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text('المزيد',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)),
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
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ]),
        ));
  }
}
