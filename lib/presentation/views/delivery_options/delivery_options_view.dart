import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_cubit.dart';
import 'data/repos/delivery_service_repo_impl.dart';
import 'widgets/delivery_options_view_body.dart';

class DeliveryOptionsView extends StatelessWidget {
  const DeliveryOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryCubit(
        DeliveryServiceRepoImpl(
          ApiServiceFunctions(Dio()),
        ),
      )..fetchDeliveryServices(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'خيارات التوصيل',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                ),
          ),
        ),
        body: const DeliveryOptionsViewBody(),
      ),
    );
  }
}
