import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:media_care/observer.dart';
import 'package:media_care/presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Auth/login/manager/login_cubit.dart';
import 'package:media_care/presentation/views/Auth/register/data/repo/register_repo_iplm.dart';
import 'package:media_care/presentation/views/Auth/register/manager/register_cubit.dart';
import 'package:media_care/presentation/views/Auth/register/regester_view.dart';
import 'package:media_care/zoom_drawer.dart';

import 'core/network/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          LoginCubit(loginRepo: LoginRepoImpl(ApiServiceFunctions(Dio()))),
    ),
    BlocProvider(
        create: (context) => RegisterCubit(
            registerRepo: RegisterRepoImpl(ApiServiceFunctions(Dio())))),
  ], child: const MediCare()));
}

class MediCare extends StatelessWidget {
  const MediCare({super.key});

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
      home: HomeView(),
    );
  }
}
