//Besttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';
import 'package:media_care/presentation/views/Doctor%20Details/manager/cubit/doctor_details_cubit.dart';
import 'package:media_care/presentation/views/Doctor%20Details/widgets/dialog.dart';
import 'package:media_care/presentation/views/Reservation/manager/cubit/reservation_cubit.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
// import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String? app_price;
  final String? full_name;
  final int? homeOption;
  final String? clinicTitle;
  final String? clinicAddress;
  final List<Appointment>? appointment;
  final DoctorDetailsModel? doctorDetailsModel;
  BookingDetailsScreen({
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
    var profileCubit =
        context.watch<ProfileCubit>(); // Get ProfileCubit instance
    String? userId =
        profileCubit.userId; // Get stored user ID// Get stored user ID
    // var user = context.read<ProfileCubit>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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
              color: Color(0xff0DCAF0),
            ),
            child: Center(
              child: Text(
                'معلومات الحجز',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'احجز كشف طبي',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff6C7582)),
          ),
          Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.moneyBill,
                        color: Color(0xff0DCAF0)),
                    SizedBox(height: 5.h),
                    Text(
                      'الكشف : ${app_price}',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6C7582)),
                    )
                  ],
                ),
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.houseUser,
                        color: Color(0xffDC3545)),
                    SizedBox(height: 5.h),
                    homeOption == 0
                        ? Text(
                            'لا يدعم الزيارة المنزلية',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6C7582)),
                          )
                        : Text(
                            'يدعم الزيارة المنزلية',
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6C7582)),
                          )
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.locationDot,
                      color: Color(0xff0DCAF0),
                      size: 25,
                    ),
                    onPressed: () {}),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '$clinicTitle ($clinicAddress)',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff595965)),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'اخـتــــــــار ميعاد الــحــجــز',
              overflow: TextOverflow.visible, // Ensures text wraps
              softWrap: true, // Allows text to break lines
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Adjust font size if needed
            ),
          ),
          Divider(
            thickness: 1.5,
          ),
          SizedBox(height: 10.h),
          // 🔹 Time Slots Section with Scrollable List 🔹
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            height: 200.h, // Fixed height to prevent overflow
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
              ],
            ),
            child: Column(
              children: [
                // Navigation Arrows and Day Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: data.currentPage > 0 ? Colors.cyan : Colors.grey,
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
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
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
                            ? Colors.cyan
                            : Colors.grey,
                      ),
                      onPressed: data.nextPage,
                    ),
                  ],
                ),
                // Scrollable List of Time Slots
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
                                      ? Colors.grey[200]
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${appointment?[index].startAt?.substring(0, 5)} مساءً - ${appointment?[index].endAt?.substring(0, 5)} مساءً',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    decoration:
                                        appointment?[index].isBooked == 1
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                    decorationColor: Colors.red,
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
                                    return BlocProvider.value(
                                      value: BlocProvider.of<ReservationCubit>(
                                          context),
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
          Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'الحجز مسبقا و الدخول بأسبقية الحضور',
              overflow: TextOverflow.visible,
              softWrap: true,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff595965)),
            ),
          ),
          Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.penToSquare,
                  color: Color(0xff0DCAF0),
                  size: 25,
                ),
                SizedBox(width: 10.w),
                Text(
                  'احجز أونلاين، ادفع في العيادة!\nالدكتور يشترط الحجز المسبق!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff595965),
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
