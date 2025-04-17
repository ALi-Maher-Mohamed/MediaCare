import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_cubit.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_state.dart';
import 'delivery_service_list.dart';

class DeliveryOptionsViewBody extends StatelessWidget {
  const DeliveryOptionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: BlocBuilder<DeliveryCubit, DeliveryState>(
        builder: (context, state) {
          if (state is DeliveryLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ));
          } else if (state is DeliveryLoaded) {
            return DeliveryServiceList(services: state.services);
          } else if (state is DeliveryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 48.w,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'اضغط لتحميل خيارات التوصيل',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
            ),
          );
        },
      ),
    );
  }
}
