import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_cubit.dart';
import 'package:media_care/presentation/views/Laboratories/manager/cubit/labs_state.dart';
import 'package:media_care/presentation/views/Laboratories/widgets/laboratory_item.dart';

import '../../../core/utils/app_color.dart';

class LaboratoryScreen extends StatefulWidget {
  @override
  _LaboratoryScreenState createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratoryScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<LaboratoryCubit>()
        .fetchLaboratories(); // تحميل أول صفحة تلقائيًا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Text(
          "المعامل",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      body: BlocBuilder<LaboratoryCubit, LaboratoryState>(
        builder: (context, state) {
          if (state is LaboratoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LaboratoryLoaded) {
            return ListView.builder(
              itemCount: state.laboratories.length,
              itemBuilder: (context, index) {
                final lab = state.laboratories[index];
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: ListTile(
                        leading: Image.network(lab.image,
                            width: 60, height: 60, fit: BoxFit.cover),
                        title: Text(lab.title),
                        subtitle:
                            Text('${lab.service} - ${lab.city}, ${lab.area}'),
                        trailing: Text('⭐ ${lab.avgRate}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LaboratoryDetailsPage(laboratory: lab),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is LaboratoryError) {
            return Center(child: Text("خطأ: ${state.error}"));
          }
          return Center(child: Text("لم يتم تحميل البيانات بعد"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LaboratoryCubit>(); // جلب الصفحة التالية
        },
        child: Icon(Icons.add), // زر لجلب المزيد من البيانات
      ),
    );
  }
}
