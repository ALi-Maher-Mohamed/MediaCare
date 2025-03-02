import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Department/data/repo/department_repo_impl.dart';
import 'package:media_care/presentation/views/Department/manager/department_cubit.dart';
import 'package:media_care/presentation/views/Department/widgets/department_view.dart';
import 'package:media_care/presentation/views/Hospital/data/repo/hospital_repo_impl.dart';
import 'package:media_care/presentation/views/Hospital/manager/hospital_cubit.dart';
import 'package:media_care/presentation/views/Hospital/widgets/hospital_view.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import 'package:media_care/presentation/views/profile/widgets/profile_ui.dart';
import 'core/Secure Storage/secure_storage.dart';
import 'core/network/api_service.dart';
import 'observer.dart';
import 'presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import 'presentation/views/Auth/login/manager/login_cubit.dart';
import 'presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'presentation/views/Auth/register/manager/register_cubit.dart';
import 'zoom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final secureStorage = const FlutterSecureStorage();
  String? token = await secureStorage.read(key: "token");
  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginCubit(loginRepo: LoginRepoImpl(ApiServiceFunctions(Dio()))),
        ),
        BlocProvider(
            create: (context) => RegisterCubit(
                registerRepo: RegisterRepoImpl(ApiServiceFunctions(Dio())))),
        BlocProvider(
            create: (context) => DepartmentCubit(
                departmentRepo:
                    DepartmentRepoImpl(ApiServiceFunctions(Dio())))..fetchDepartments()),
        BlocProvider(
            create: (context) => HospitalCubit(
                hospitalRepo:
                HospitalRepoImpl(ApiServiceFunctions(Dio())))..fetchHospitals()),
        BlocProvider(
            create: (context) => ProfileCubit(
                profileRepo: ProfileRepoImpl(ApiServiceFunctions(Dio())),
                secureStorage: SecureStorage())
              ..fetchProfile()),
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
    return MaterialApp(
      locale: Locale('ar'),
      builder: EasyLoading.init(builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          // يجعل التطبيق بالكامل من اليسار لليمين
          child: child!,
        );
      }),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? DepartmentsScreen() : LoginView(),
    );
  }
}
