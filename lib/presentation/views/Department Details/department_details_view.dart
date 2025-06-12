import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Department%20Details/data/models/department_details_model.dart';
import 'package:media_care/presentation/views/Department%20Details/data/repo/department_details_repo_impl.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_cubit.dart';
import 'package:media_care/presentation/views/Department%20Details/manager/department_details_state.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/FilterButton.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/care_center_card.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/doctor_card.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/hospital_card.dart';
import 'package:media_care/presentation/views/Department%20Details/widgets/tip_card.dart';

class DepartmentDetailsScreen extends StatelessWidget {
  final String departmentID;
  final String title;

  const DepartmentDetailsScreen(
      {Key? key, required this.departmentID, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentDetailsCubit(
        departmentDetailsRepoImpl: DepartmentDetailsRepoImpl(
          ApiServiceFunctions(Dio()),
        ),
      )..getDepartmentDetails(departmentID),
      child: BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
        builder: (context, state) {
          if (state is DepartmentDetailsLoading) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: CustomProgressIndicator(),
            );
          } else if (state is DepartmentDetailsLoaded) {
            String selectedCategory = state.selectedCategory;
            List<Tip> tips = state.departmentDetails.data.tips;
            // Access lists from cubit
            final cubit = context.read<DepartmentDetailsCubit>();
            List<Hospital> hospitals = cubit.hospitals;
            List<CareCenter> careCenters = cubit.careCenters;
            List<Doctor> doctors = cubit.doctors;

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                forceMaterialTransparency: true,
                iconTheme: Theme.of(context).iconTheme,
                title: Text(
                  '$title',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Column(
                children: [
                  // Tips Carousel Section
                  if (tips.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'نصائح طبية',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              enlargeCenterPage: true,
                              viewportFraction: 0.85,
                            ),
                            items:
                                tips.map((tip) => TipCard(tip: tip)).toList(),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                  // Categories Row (Show buttons only if data exists)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (hospitals.isNotEmpty)
                          CategoryButton(
                            title: "المستشفيات",
                            isSelected: selectedCategory == "المستشفيات",
                            onTap: () => context
                                .read<DepartmentDetailsCubit>()
                                .filterDepartmentData("المستشفيات"),
                          ),
                        if (careCenters.isNotEmpty)
                          CategoryButton(
                            title: "المراكز",
                            isSelected: selectedCategory == "المراكز",
                            onTap: () => context
                                .read<DepartmentDetailsCubit>()
                                .filterDepartmentData("المراكز"),
                          ),
                        if (doctors.isNotEmpty)
                          CategoryButton(
                            title: "الأطباء",
                            isSelected: selectedCategory == "الأطباء",
                            onTap: () => context
                                .read<DepartmentDetailsCubit>()
                                .filterDepartmentData("الأطباء"),
                          ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  // Data ListView
                  Expanded(
                    child: ListView(
                      children: state.filteredData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        Widget card;
                        if (item.runtimeType == Hospital) {
                          card = HospitalCard(hospital: item as Hospital);
                        } else if (item.runtimeType == CareCenter) {
                          card = CareCenterCard(careCenter: item as CareCenter);
                        } else if (item.runtimeType == Doctor) {
                          card = DoctorCard(doctor: item as Doctor);
                        } else {
                          card = Container();
                        }
                        return card
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: (100 * index).ms,
                            )
                            .slideX(begin: 0.2);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DepartmentDetailsError) {
            return Center(
                child: Text('Error: ${state.message}',
                    style: Theme.of(context).textTheme.bodyMedium));
          }
          return Center(
              child: Text('Unknown state',
                  style: Theme.of(context).textTheme.bodyMedium));
        },
      ),
    );
  }
}
