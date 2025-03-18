import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Auth/logout/data/repo/logout_repo_impl.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_cubit.dart';
import '../../../../core/utils/app_color.dart';
import 'menu_view_body.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryLight,
        body: BlocProvider(
          create: (context) => LogoutCubit(
              logoutRepo: LogoutRepoImpl(ApiServiceFunctions(Dio()))),
          child: MenuViewBody(),
        ));
  }
}
