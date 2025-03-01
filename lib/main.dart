import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:media_care/presentation/views/splash/splash_view.dart';
import 'observer.dart';
import 'presentation/views/Auth/login/login_view.dart';
import 'presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import 'presentation/views/Auth/login/manager/login_cubit.dart';
import 'presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'presentation/views/Auth/register/manager/register_cubit.dart';
import 'presentation/views/pharmacies/data/service/api_service.dart';
import 'presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'zoom_drawer.dart';

import 'package:media_care/presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Auth/login/manager/login_cubit.dart';
import 'package:media_care/presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'package:media_care/presentation/views/Auth/register/manager/register_cubit.dart';
import 'package:media_care/presentation/views/pharmacies/data/service/api_service.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'package:media_care/zoom_drawer.dart';

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
            textDirection: TextDirection.ltr,
            // يجعل التطبيق بالكامل من اليسار لليمين
            child: child!,
          );
        }),
        debugShowCheckedModeBanner: false,
        home:
            // isLoggedIn ?
            HomeView()
        // : LoginView(),
        );
  }
}
