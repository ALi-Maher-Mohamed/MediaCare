import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_cubit.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/dialog.dart';
import 'package:media_care/presentation/views/Reservation/data/repo/reservation_repo_impl.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_cubit.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String? app_price;
  final String? full_name;
  final int? homeOption;
  final String? clinicTitle;
  final String? clinicAddress;
  final List<Appointment>? appointment;
  final DoctorDetailsModel? doctorDetailsModel;

  const BookingDetailsScreen({
    this.full_name,
    this.app_price,
    this.homeOption,
    this.clinicTitle,
    this.clinicAddress,
    this.appointment,
    this.doctorDetailsModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var data = context.read<DoctorDetailsCubit>();
    var profileCubit = context.watch<ProfileCubit>();
    String? userId = profileCubit.userId;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Container(
            height: 40.h,
            width: 250.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'معلومات الحجز',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'احجز كشف طبي',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.moneyBill,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(height: 5.h),
                    Text(
                      'الكشف : ${app_price}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.houseUser,
                        color: Theme.of(context).colorScheme.error),
                    SizedBox(height: 5.h),
                    homeOption == 0
                        ? Text(
                            'لا يدعم الزيارة المنزلية',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          )
                        : Text(
                            'يدعم الزيارة المنزلية',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.locationDot,
                    color: Theme.of(context).colorScheme.primary,
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '$clinicTitle ($clinicAddress)',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'اخـتــــــــار ميعاد الــحــجــز',
              overflow: TextOverflow.visible,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          SizedBox(height: 10.h),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: data.currentPage > 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      onPressed: data.previousPage,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          doctorDetailsModel
                                  ?.data?.appointmentsGroupedByDate?.keys
                                  .elementAt(data.currentPage) ??
                              'لا توجد مواعيد متاحه',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: data.currentPage <
                                (doctorDetailsModel
                                            ?.data
                                            ?.appointmentsGroupedByDate
                                            ?.length ??
                                        1) -
                                    1
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      onPressed: data.nextPage,
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: data.pageController,
                    itemCount: appointment?.length,
                    onPageChanged: (index) {
                      data.currentPage = index;
                    },
                    itemBuilder: (context, pageIndex) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: appointment?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: appointment?[index].isBooked == 1
                                      ? Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant
                                      : Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${appointment?[index].startAt?.substring(0, 5)} مساءً - ${appointment?[index].endAt?.substring(0, 5)} مساءً',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        decoration:
                                            appointment?[index].isBooked == 1
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                        decorationColor:
                                            Theme.of(context).colorScheme.error,
                                        decorationThickness: 3,
                                      ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (appointment?[index].isBooked != 1) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider(
                                      create: (context) => ReservationCubit(
                                        reservaionRepo: ReservaionRepoImpl(
                                            ApiServiceFunctions(Dio())),
                                      ),
                                      child: ReservationDialog(
                                        appointment_time:
                                            '${appointment?[index].startAt?.substring(0, 5)} مساءً ',
                                        clinicTitle: clinicTitle,
                                        full_name: full_name,
                                        appointment_id: appointment?[index].id,
                                        clinic_id: doctorDetailsModel
                                            ?.data?.clinics?[0].id,
                                        doctor_id: doctorDetailsModel?.data?.id,
                                        status:
                                            appointment?[index].isBooked == 1
                                                ? "pending"
                                                : null,
                                        user_id: userId,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'الحجز مسبقا و الدخول بأسبقية الحضور',
              overflow: TextOverflow.visible,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.penToSquare,
                  color: Theme.of(context).colorScheme.primary,
                  size: 25,
                ),
                SizedBox(width: 10.w),
                Text(
                  'احجز أونلاين، ادفع في العيادة!\nالدكتور يشترط الحجز المسبق!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
