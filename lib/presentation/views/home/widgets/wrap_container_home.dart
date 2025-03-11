import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department/widgets/department_view.dart';
import 'package:media_care/presentation/views/doctor_blogs/data/repos/doctor_blogs_repo.dart';
import 'package:media_care/presentation/views/doctor_blogs/doctor_blogs_view.dart';
import 'package:media_care/presentation/views/doctor_blogs/manager/cubit/blogs_cubit.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import '../../Laboratories/Labs_view.dart';
import '../../Laboratories/data/services/laps_service.dart';
import '../../Laboratories/manager/cubit/labs_cubit.dart';
import 'custom_home_feature_container.dart';
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
                create: (context) => PharmacyCubit(PharmacyRepoImpl(Dio())),
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
              return DepartmentsView();
            }));
          },
        ),
        CustomHomeFeatureContainer(
          image: 'assets/pharmacies/blogs.jfif',
          text: 'المقالات الطبية',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorBlogsView();
            }));
          },
        ),
      ],
    );
  }
}
