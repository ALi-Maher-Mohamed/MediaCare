import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import '../manager/hospital_cubit.dart';
import '../manager/hospital_state.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals'),
      ),
      body: BlocConsumer<HospitalCubit, HospitalState>(
        listener: (context, state) {
          if (state is HospitalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is HospitalInitial) {
            return Center(child: Text('Initial state'));
          } else if (state is HospitalLoading) {
            return CustomProgressIndicator();
          } else if (state is HospitalLoaded) {
            final hospitals = state.hospitalModel.data; // List<Data>?
            if (hospitals == null || hospitals.isEmpty) {
              return Center(child: Text('No hospitals found'));
            }
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return ListTile(
                  leading: hospital.image,
                  title:
                      Text(hospital.title ?? 'No Title'), // Handle null title
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hospital.service ??
                          'No Service'), // Handle null service
                      Text(hospital.address ??
                          'No Address'), // Handle null address
                      Text(hospital.phone ?? 'No Phone'), // Handle null phone
                    ],
                  ),
                  onTap: () {
                    // Handle hospital tap (e.g., navigate to details screen)
                  },
                );
              },
            );
          } else if (state is HospitalError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
