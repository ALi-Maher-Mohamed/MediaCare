import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo_impl.dart';
import 'package:media_care/presentation/views/Department/manager/department_cubit.dart';
import 'package:media_care/presentation/views/Hospital/data/repo/hospital_repo_impl.dart';
import 'package:media_care/presentation/views/Hospital/manager/hospital_cubit.dart';
import 'package:media_care/presentation/views/Reservation/data/repo/reservation_repo_impl.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_cubit.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import 'core/network/api_service.dart';
import 'observer.dart';
import 'presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import 'presentation/views/Auth/login/manager/login_cubit.dart';
import 'presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'presentation/views/Auth/register/manager/register_cubit.dart';
import 'zoom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final service = LaboratoryRepoImpl(Dio());
  // final result = await service.getLaboratories(page: 1);

  // print('Test API call: ${result.laboratories}');
  String? token = await SharedPreference().getToken();
  print("tokkkkkkkkkkkkkkkkkkkkkkkkenn : $token");

  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReservationCubit(
            reservaionRepo: ReservaionRepoImpl(ApiServiceFunctions(Dio())),
          ),
        ),
        BlocProvider(
            create: (context) => ProfileCubit(
                  profileRepo: ProfileRepoImpl(ApiServiceFunctions(Dio())),
                )..fetchProfile()),
        BlocProvider(
          create: (context) =>
              LoginCubit(loginRepo: LoginRepoImpl(ApiServiceFunctions(Dio()))),
        ),
        BlocProvider(
            create: (context) => RegisterCubit(
                registerRepo: RegisterRepoImpl(ApiServiceFunctions(Dio())))),
        BlocProvider(
            create: (context) => DepartmentCubit(
                departmentRepo: DepartmentRepoImpl(ApiServiceFunctions(Dio())))
              ..fetchDepartments()),
        BlocProvider(
            create: (context) => HospitalCubit(
                hospitalRepo: HospitalRepoImpl(ApiServiceFunctions(Dio())))
              ..fetchHospitals()),
      ],
      child: MediCare(
        isLoggedIn: token != null,
      )));
}

class MediCare extends StatelessWidget {
  final bool isLoggedIn;

  MediCare({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        locale: Locale('ar'),
        builder: EasyLoading.init(builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            // يجعل التطبيق بالكامل من اليسار لليمين
            child: child!,
          );
        }),
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? HomeView() : HomeView(),
      ),
    );
  }
}
