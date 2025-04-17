import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/functins/launch_url.dart';
import 'package:media_care/presentation/views/delivery_options/data/repos/delivery_service_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_cubit.dart';
import 'package:media_care/presentation/views/delivery_options/manager/cubit/delivery_cubit_state.dart';

class DeliveryOptionsRow extends StatelessWidget {
  const DeliveryOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryCubit(
        DeliveryServiceRepoImpl(ApiServiceFunctions(Dio())),
      )..fetchDeliveryServices(),
      child: BlocBuilder<DeliveryCubit, DeliveryState>(
        builder: (context, state) {
          if (state is DeliveryLoading) {
            return SizedBox(
              height: 120.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (state is DeliveryLoaded) {
            final services =
                state.services.take(2).toList(); // عرض أول خدمتين فقط
            return SizedBox(
              height: 120.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Container(
                    width: 200.w,
                    margin: EdgeInsets.only(right: 16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.local_shipping,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20.w,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  service.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            service.description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 12.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () =>
                                  launchCustomUrl(context, service.appLink),
                              child: Text(
                                'زيارة',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is DeliveryError) {
            return SizedBox(
              height: 120.h,
              child: Center(
                child: Text(
                  'خطأ: ${state.message}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            );
          }
          return SizedBox(
            height: 120.h,
            child: const Center(child: Text('لا توجد بيانات')),
          );
        },
      ),
    );
  }
}
