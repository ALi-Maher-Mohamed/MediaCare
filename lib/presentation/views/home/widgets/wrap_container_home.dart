import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Doctor%20Speciality/DocSpeciality.dart';
import '../../Laboratories/Labs_view.dart';
import '../../Laboratories/data/services/laps_service.dart';
import '../../Laboratories/manager/cubit/labs_cubit.dart';
import 'custom_home_feature_container.dart';
import '../../pharmacies/data/service/pharmacy_service.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import '../../pharmacies/pharmacy_view.dart';

class CustomWrapContainersHomeView extends StatelessWidget {
  const CustomWrapContainersHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceAround,
      runSpacing: 10.h,
      spacing: 10.w,
      direction: Axis.horizontal,
      children: [
        CustomHomeFeatureContainer(
          image: 'assets/pharmacies/pharmacy_icon.png',
          text: 'الصيدلياتٍ',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => PharmacyCubit(PharmacyService()),
                child: PharmacyView(),
              );
            }));
          },
        ),
        CustomHomeFeatureContainer(
          image: 'assets/pharmacies/labs.png',
          text: 'المعامل ',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => LaboratoryCubit(LaboratoryService()),
                child: LaboratoryView(),
              );
            }));
          },
        ),
        CustomHomeFeatureContainer(
          image: 'assets/pharmacies/doctors_icon.png',
          text: 'الاقسام الطبية ',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorSpecialityView();
            }));
          },
        ),
        CustomHomeFeatureContainer(
          image: 'assets/pharmacies/blogs.jfif',
          text: 'المقالات الطبية',
        ),
      ],
    );
  }
}
