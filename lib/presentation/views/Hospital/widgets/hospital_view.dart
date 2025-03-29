import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/Hospital/data/repo/hospital_repo_impl.dart';
import '../manager/hospital_cubit.dart';
import '../manager/hospital_state.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
      ),
      body: BlocProvider(
        create: (context) => HospitalCubit(
            hospitalRepo: HospitalRepoImpl(ApiServiceFunctions(Dio())))
          ..fetchHospitals(),
        child: BlocConsumer<HospitalCubit, HospitalState>(
          listener: (context, state) {
            if (state is HospitalError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is HospitalLoading) {
              return const CustomProgressIndicator();
            } else if (state is HospitalLoaded) {
              final hospitals = state.hospitalModel.data;
              if (hospitals == null || hospitals.isEmpty) {
                return const Center(child: Text('No hospitals found'));
              }
              return ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = hospitals[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      leading: hospital.image,
                      title: Text(hospital.title ?? 'No Title',
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hospital.service ?? 'No Service',
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(hospital.address ?? 'No Address',
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(hospital.phone ?? 'No Phone',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                },
              );
            } else if (state is HospitalError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
