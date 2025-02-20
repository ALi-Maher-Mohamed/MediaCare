import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';

class PharmacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الصيدليات')),
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PharmacyLoaded) {
            return ListView.builder(
              itemCount: state.pharmacies.length,
              itemBuilder: (context, index) {
                PharmacyModel pharmacy = state.pharmacies[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(pharmacy.image,
                        width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(pharmacy.title),
                    subtitle: Text(
                        '${pharmacy.city} - ${pharmacy.area}\n${pharmacy.service}'),
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: Colors.green),
                      onPressed: () {
                        // تنفيذ الاتصال عند الضغط على الزر
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is PharmacyError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Center(child: Text('لا توجد بيانات متاحة'));
        },
      ),
    );
  }
}
